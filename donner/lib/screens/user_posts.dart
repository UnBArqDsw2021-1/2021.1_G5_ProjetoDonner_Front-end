import 'package:donner/controllers/authentication.dart';
import 'package:donner/models/announcement_model.dart';
import 'package:donner/models/client_model.dart';
import 'package:donner/shared/services/firestore_service.dart';
import 'package:donner/shared/themes/app_colors.dart';
import 'package:donner/shared/themes/app_text_styles.dart';
import 'package:donner/shared/widgets/announcement_tile_widget.dart';
import 'package:donner/shared/widgets/sidebar_widget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class UserPosts extends StatefulWidget {
  String? user;
  UserPosts({Key? key}) : super(key: key) {
    user = Authentication().getUser()!.uid;
  }

  @override
  _UserPostsState createState() => _UserPostsState();
}

class _UserPostsState extends State<UserPosts> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primary,
      ),
      body: FutureBuilder<List<AnnouncementModel>>(
          future: FirestoreService().getUserAnnouncements(widget.user!),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    AnnouncementModel announcement = snapshot.data![index];
                    return Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Image.network(
                              announcement.images!,
                              height: 200,
                              width: 100,
                              fit: BoxFit.fitWidth,
                            ),
                            Container(
                              padding: const EdgeInsets.all(8),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    width: 200,
                                    child: Text(
                                      announcement.title!,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w500),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                GestureDetector(
                                    onTap: () {
                                      FirestoreService()
                                          .deleteAnnouncement(announcement.id!);
                                      setState(() {});
                                    },
                                    child: const Icon(
                                      FontAwesomeIcons.trashAlt,
                                      color: AppColors.terciary,
                                      size: 30,
                                    )),
                                const SizedBox(height: 120,),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.pushNamed(
                                      context,
                                      '/edit_post',
                                      arguments: announcement,
                                    );
                                  },
                                  child: const Icon(
                                    FontAwesomeIcons.edit,
                                    color: AppColors.secondary,
                                    size: 30,
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
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
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(top: 20),
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
            child: const Icon(
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
              child: const Icon(
                Icons.person_outline,
                color: AppColors.backgroundColor,
                size: 35,
              ),
            ),
            GestureDetector(
              onTap: () {},
              child: const Icon(
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
