import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:donner/models/announcement_model.dart';
import 'package:donner/shared/services/firestore_service.dart';
import 'package:donner/shared/themes/app_colors.dart';
import 'package:donner/shared/themes/app_text_styles.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AnnouncementTileWidget extends StatelessWidget {
  final AnnouncementModel announcement;
  final String type;
  bool showExcludedButton;
  AnnouncementTileWidget({
    Key? key,
    required this.announcement,
    required this.type,
    this.showExcludedButton = false,
  }) : super(key: key) {
    showExcludedButton = showExcludedButton;
  }
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot>(
      future: FirestoreService().findUser(announcement.owner!),
      builder: (context, snapshot) {
        if (!snapshot.hasData)
          return Center(child: CircularProgressIndicator());
        return Card(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: type == "grid"
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AspectRatio(
                      aspectRatio: 0.9,
                      child: Image.network(
                        announcement.images!,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Expanded(
                        child: Container(
                      padding: EdgeInsets.all(8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            announcement.title!,
                            style: const TextStyle(fontWeight: FontWeight.w500),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                          ),
                          Container(
                            height: 15,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Flexible(
                                  child: Text(
                                    "${snapshot.data!.get('city')} - ${snapshot.data!.get('state')}",
                                    style: AppTextStyles.inputText,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {},
                                  child: const Icon(
                                    FontAwesomeIcons.heart,
                                    color: AppColors.secondary,
                                    size: 15,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ))
                  ],
                )
              : Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Flexible(
                        flex: 1,
                        child: Image.network(
                          announcement.images!,
                          height: 250,
                        ),
                      ),
                      Flexible(
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: 200,
                                child: showExcludedButton
                                    ? Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            announcement.title!,
                                            style: const TextStyle(
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              Navigator.pushNamed(
                                                context,
                                                '/edit_post',
                                                arguments: announcement,
                                              );
                                            },
                                            child: Icon(
                                              FontAwesomeIcons.edit,
                                              color: AppColors.secondary,
                                              size: 20,
                                            ),
                                          ),
                                        ],
                                      )
                                    : Text(
                                        announcement.title!,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "${snapshot.data!.get('city')} - ${snapshot.data!.get('state')}",
                                    style: AppTextStyles.inputText,
                                  ),
                                  GestureDetector(
                                    onTap: () async {
                                      if (showExcludedButton) {
                                        await FirestoreService()
                                            .deleteAnnouncement(
                                                announcement.id!);
                                        Navigator.pushReplacementNamed(
                                            context, '/my_posts');
                                      }
                                    },
                                    child: showExcludedButton
                                        ? Icon(
                                            FontAwesomeIcons.trashAlt,
                                            color: AppColors.terciary,
                                            size: 20,
                                          )
                                        : Icon(
                                            FontAwesomeIcons.heart,
                                            color: AppColors.secondary,
                                            size: 20,
                                          ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
        );
      },
    );
  }
}
