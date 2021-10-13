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
  const AnnouncementTileWidget({Key? key, required this.announcement})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot>(
        future: FirestoreService().findUser(announcement.owner!),
        builder: (context, snapshot) {
          if (!snapshot.hasData)
            return Center(child: CircularProgressIndicator());
          return Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
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
                            Text(
                              "${snapshot.data!.get('city')} - ${snapshot.data!.get('state')}",
                              style: AppTextStyles.inputText,
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
            ),
          );
        });
  }
}
