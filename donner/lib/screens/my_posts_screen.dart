import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:donner/controllers/authentication.dart';
import 'package:donner/models/announcement_model.dart';
import 'package:donner/models/client_model.dart';
import 'package:donner/shared/services/firestore_service.dart';
import 'package:donner/shared/themes/app_colors.dart';
import 'package:donner/shared/themes/app_text_styles.dart';
import 'package:donner/shared/widgets/announcement_tile_widget.dart';
import 'package:donner/shared/widgets/bottom_bar/bottom_bar_widget.dart';
import 'package:donner/shared/widgets/bottom_bar/floating_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MyPostsScreen extends StatelessWidget {
  const MyPostsScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor,
        centerTitle: true,
        elevation: 0,
        leading: GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: const Icon(
              FontAwesomeIcons.chevronLeft,
              color: AppColors.secondary,
              size: 30,
            )),
        title: Text("Minhas Postagens", style: AppTextStyles.pageTitleText),
      ),
      body: FutureBuilder<QuerySnapshot>(
          future: FirestoreService()
              .getAnnouncementsByUserId(Authentication().getUser()!.uid),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return ListView.builder(
                padding: const EdgeInsets.all(4),
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  return AnnouncementTileWidget(
                    showExcludedButton: true,
                    type: "list",
                    announcement: AnnouncementModel.fromDocument(
                      snapshot.data!.docs[index],
                    ),
                  );
                },
              );
            }
          }),
      floatingActionButton: FloatingButton(
        onPressed: () {
          Navigator.pushReplacementNamed(context, '/create_post');
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomBarWidget(
        onTapPerson: () {
          // Navigator.pushReplacementNamed(
          //   context,
          //   '/profile',
          //   arguments: user,
          // );
        },
      ),
    );
  }
}
