import 'package:donner/controllers/authentication.dart';
import 'package:donner/models/client_model.dart';
import 'package:donner/shared/themes/app_colors.dart';
import 'package:donner/shared/widgets/sidebar_widget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'available_posts.dart';

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
      body: const AvailablePosts(),
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
      floatingActionButton: Padding(
        padding: EdgeInsets.only(top: 20),
        child: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, "/create_post");
          },
          backgroundColor: Colors.transparent,
          elevation: 0,
          child: Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.backgroundColor,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.5),
                  blurRadius: 7,
                  spreadRadius: 1.8,
                  offset: const Offset(0, -0.1),
                ),
              ],
            ),
            child: Icon(
              Icons.add_rounded,
              size: 40,
              color: AppColors.secondary,
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: Container(
        color: AppColors.primary,
        height: 50,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            GestureDetector(
              onTap: () {},
              child: Icon(
                Icons.person_outline,
                color: AppColors.backgroundColor,
                size: 35,
              ),
            ),
            GestureDetector(
              onTap: () {},
              child: Icon(
                Icons.home_outlined,
                size: 35,
                color: AppColors.backgroundColor,
              ),
            )
          ],
        ),
      ),
    );
  }
}
