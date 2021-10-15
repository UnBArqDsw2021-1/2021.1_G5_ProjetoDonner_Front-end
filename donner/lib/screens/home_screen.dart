import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:donner/controllers/authentication.dart';
import 'package:donner/models/announcement_model.dart';
import 'package:donner/models/client_model.dart';
import 'package:donner/shared/services/firestore_service.dart';
import 'package:donner/shared/themes/app_colors.dart';
import 'package:donner/shared/widgets/announcement_tile_widget.dart';
import 'package:donner/shared/widgets/bottom_bar/bottom_bar_widget.dart';
import 'package:donner/shared/widgets/bottom_bar/floating_button_widget.dart';
import 'package:donner/shared/widgets/sidebar_widget.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  ClientModel? user;
  HomeScreen({Key? key, this.user}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primary,
      ),
      body: FutureBuilder<QuerySnapshot>(
          future: FirestoreService().getAnnouncements(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return GridView.builder(
                  padding: EdgeInsets.all(10),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
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
                  });
            }
          }),
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
            // Navigator.pushNamed(context, "/login");
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Ação necessita de login'),
                elevation: 0,
                behavior: SnackBarBehavior.floating,
                width: 200,
                backgroundColor: AppColors.primary,
                duration: Duration(
                  seconds: 1,
                ),
              ),
            );
          }
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomBarWidget(
        onTapHome: () {},
        onTapPerson: () async {
          String userId = Authentication().getUser()!.uid;
          DocumentSnapshot user = await FirestoreService().findUser(userId);
          Navigator.pushNamed(context, '/profile',
              arguments: ClientModel.fromSnapshot(user));
        },
      ),

    );
  }
}
