import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:donner/controllers/authentication.dart';
import 'package:donner/models/announcement_model.dart';
import 'package:donner/models/category_model.dart';
import 'package:donner/models/client_model.dart';
import 'package:donner/shared/services/firestore_service.dart';
import 'package:donner/shared/themes/app_colors.dart';
import 'package:donner/shared/widgets/announcement_tile_widget.dart';
import 'package:donner/shared/widgets/bottom_bar/bottom_bar_widget.dart';
import 'package:donner/shared/widgets/bottom_bar/floating_button_widget.dart';
import 'package:donner/shared/widgets/sidebar_widget.dart';
import 'package:donner/shared/widgets/top_bar_widget/top_bar_widget.dart';

class HomeScreen extends StatefulWidget {
  ClientModel? user;
  CategoryModel? category;
  HomeScreen({Key? key, this.user, this.category}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Map filters = {};
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        elevation: 0,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TopBarWidget(
            onTapFilter: () async {
              final result =
                  await Navigator.pushNamed(context, '/filter') as Map?;
              if (result != null) {
                filters = result;
                widget.category = filters['category'];
                setState(() {});
              }
            },
            category: widget.category,
            onTapCategory: () async {
              final result = await Navigator.pushNamed(context, '/category')
                  as CategoryModel?;
              widget.category = result;
              filters['category'] = widget.category!.id;
              setState(
                () {},
              );
            },
          ),
          Expanded(
            child: FutureBuilder<QuerySnapshot>(
              future: FirestoreService().getAnnouncements(
                  category:
                      widget.category != null ? widget.category!.id : null,
                  isDonation: filters['isDonation'],
                  date: true),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  return GridView.builder(
                    padding: EdgeInsets.all(10),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisSpacing: 4,
                      mainAxisSpacing: 4,
                      crossAxisCount: 2,
                      childAspectRatio: 0.65,
                    ),
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      final announcement = AnnouncementModel.fromDocument(
                          snapshot.data!.docs[index]);
                      return InkWell(
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            '/post',
                            arguments: announcement,
                          );
                        },
                        child: AnnouncementTileWidget(
                          type: "grid",
                          announcement: announcement,
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
      drawer: FutureBuilder<ClientModel?>(
        future: Authentication().getUserInfo(),
        builder: (context, snap) {
          if (snap.hasError) {
            return SnackBar(
              content: Text(snap.error.toString()),
            );
          } else {
            return SidebarWidget(
              user: snap.data,
            );
          }
        },
      ),
      floatingActionButton: FloatingButton(
        onPressed: () {
          if (Authentication().getUser() != null) {
            Navigator.pushNamed(context, "/create_post");
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text(
                  'Ação necessita de login',
                  textAlign: TextAlign.center,
                ),
                elevation: 0,
                behavior: SnackBarBehavior.floating,
                width: 200,
                backgroundColor: AppColors.primary,
                duration: Duration(
                  milliseconds: 1500,
                ),
              ),
            );
          }
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomBarWidget(
        onTapHome: () {
          Navigator.pushReplacementNamed(
            context,
            '/home',
          );
        },
        onTapPerson: () async {
          if (Authentication().getUser() != null) {
            ClientModel? client = await Authentication().getUserInfo();
            Navigator.pushNamed(
              context,
              '/profile',
              arguments: client!,
            );
          } else {
            Navigator.pushReplacementNamed(
              context,
              '/login',
            );
          }
        },
      ),
    );
  }
}
