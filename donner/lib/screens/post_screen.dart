import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:donner/controllers/authentication.dart';
import 'package:donner/models/announcement_model.dart';
import 'package:donner/models/client_model.dart';
import 'package:donner/shared/services/firestore_service.dart';
import 'package:donner/shared/themes/app_colors.dart';
import 'package:donner/shared/themes/app_text_styles.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PostScreen extends StatelessWidget {
  final AnnouncementModel announcement;
  const PostScreen({Key? key, required this.announcement}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
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
        actions: (announcement.owner == Authentication().getUser()!.uid)
            ? [
                Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: IconButton(
                    onPressed: () {
                      Navigator.pushNamed(context, "/edit_post",
                          arguments: announcement);
                    },
                    icon: const Icon(
                      FontAwesomeIcons.edit,
                      color: AppColors.secondary,
                      size: 30,
                    ),
                  ),
                ),
              ]
            : null,
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    announcement.title!,
                    style: AppTextStyles.secondaryPageTitleText,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Center(
                    child: Container(
                      width: 250.0,
                      height: 250.0,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(announcement.images!),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Text(
                    "DESCRIÇÂO",
                    style: AppTextStyles.bodyText,
                    textAlign: TextAlign.left,
                  ),
                ),
                const Divider(thickness: 0.5, color: AppColors.stroke),
                Container(
                  alignment: Alignment.topLeft,
                  height: 150,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: AppColors.backgroundColor,
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.secondary.withOpacity(0.5),
                        blurRadius: 7,
                        spreadRadius: 1.8,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Text(
                    announcement.description!,
                    style: AppTextStyles.cardText,
                  ),
                ),
                FutureBuilder<DocumentSnapshot>(
                  future: FirestoreService().findUser(announcement.owner!),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Center(child: CircularProgressIndicator());
                    }

                    final owner = ClientModel.fromSnapshot(snapshot.data);
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: Text(
                            "ANUNCIANTE",
                            style: AppTextStyles.bodyText,
                            textAlign: TextAlign.left,
                          ),
                        ),
                        const Divider(thickness: 0.5, color: AppColors.stroke),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              '/profile',
                              arguments: owner,
                            );
                          },
                          child: Container(
                            alignment: Alignment.topLeft,
                            height: 80,
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: AppColors.backgroundColor,
                              boxShadow: [
                                BoxShadow(
                                  color: AppColors.primary.withOpacity(0.5),
                                  blurRadius: 7,
                                  spreadRadius: 1.8,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 10),
                                        child: Container(
                                          width: 50.0,
                                          height: 50.0,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image:
                                                  NetworkImage(owner.photoUrl!),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            owner.name,
                                            style: AppTextStyles.bodyTextSmall,
                                          ),
                                          Text(
                                            "${owner.city} - ${owner.state}",
                                            style: AppTextStyles.bodyTextSmall,
                                          ),
                                          Text(
                                            owner.email,
                                            style: AppTextStyles.bodyTextSmall,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Text(
                                  'Perfil',
                                  style: AppTextStyles.bodyTextSmall
                                      .merge(const TextStyle(
                                    decoration: TextDecoration.underline,
                                  )),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
