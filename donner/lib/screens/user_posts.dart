import 'package:donner/controllers/announcement_controller.dart';
import 'package:donner/controllers/authentication.dart';
import 'package:donner/models/announcement_model.dart';
import 'package:donner/models/client_model.dart';
import 'package:donner/shared/services/firestore_service.dart';
import 'package:donner/shared/themes/app_colors.dart';
import 'package:donner/shared/themes/app_text_styles.dart';
import 'package:donner/shared/widgets/announcement_tile_widget.dart';
import 'package:donner/shared/widgets/bottom_bar/bottom_bar_widget.dart';
import 'package:donner/shared/widgets/bottom_bar/floating_button_widget.dart';
import 'package:donner/shared/widgets/sidebar_widget.dart';
import 'package:firebase_storage/firebase_storage.dart';
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
          title: Text("Minhas postagens", style: AppTextStyles.pageTitleText),
          elevation: 0,
          backgroundColor: Colors.transparent,
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
                          Container(
                            width: 150,
                            child: Image.network(
                              announcement.images!,
                              fit: BoxFit.fitWidth,
                              height: 200,
                            ),
                          ),
                          Flexible(
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
                              width: 200,
                              child: Text(
                                announcement.title!,
                                style: AppTextStyles.cardText,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 3,
                              ),
                            ),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              GestureDetector(
                                  onTap: () async{
                                    await FirestoreService()
                                        .deleteAnnouncement(announcement.id!);
                                  },
                                  child: const Icon(
                                    FontAwesomeIcons.trashAlt,
                                    color: AppColors.terciary,
                                    size: 30,
                                  )),
                              const SizedBox(
                                height: 120,
                              ),
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
                },
              );
            }
          },
        ),
        floatingActionButton: FloatingButton(onPressed: () {
          Navigator.pushNamed(
            context,
            '/create_post',
          );
        }),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: BottomBarWidget(
          onTapPerson: () async {
            ClientModel? client = await Authentication().getUserInfo();
            Navigator.popAndPushNamed(
              context,
              '/profile',
              arguments: client!,
            );
          },
          onTapHome: () {
            // Navigator.popUntil(context, ModalRoute.withName('/home'));
          },
        ));
  }
}
