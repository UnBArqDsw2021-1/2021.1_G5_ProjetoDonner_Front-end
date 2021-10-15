import 'package:donner/controllers/authentication.dart';
import 'package:donner/models/announcement_model.dart';
import 'package:donner/models/client_model.dart';
import 'package:donner/shared/services/firestore_service.dart';
import 'package:donner/shared/themes/app_colors.dart';
import 'package:donner/shared/themes/app_text_styles.dart';
import 'package:donner/shared/widgets/info_tile_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ProfileScreen extends StatefulWidget {
  final ClientModel user;
  const ProfileScreen({Key? key, required this.user}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool isCurrentUser = Authentication().getUser() != null &&
        widget.user.id == Authentication().getUser()!.uid;

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
          actions: (isCurrentUser)
              ? [
                  Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: IconButton(
                      onPressed: () {
                        Navigator.pushNamed(
                          context,
                          "/edit_profile",
                          arguments: widget.user,
                        );
                      },
                      icon: const Icon(
                        FontAwesomeIcons.edit,
                        color: AppColors.primary,
                        size: 30,
                      ),
                    ),
                  ),
                ]
              : null),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 150.0,
                  height: 150.0,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(widget.user.photoUrl!),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      widget.user.name,
                      style: AppTextStyles.bodyText,
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    isCurrentUser
                        ? GestureDetector(
                            onTap: () {
                              Authentication().signOut(context);
                            },
                            child: const Icon(
                              Icons.logout,
                              color: AppColors.primary,
                            ),
                          )
                        : Container(),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 30, left: 10, right: 10),
                child: Wrap(
                  runSpacing: 10,
                  children: [
                    InfoTileWidget(
                      icon: const Icon(
                        FontAwesomeIcons.phone,
                        color: AppColors.primary,
                      ),
                      info: widget.user.phone!,
                    ),
                    InfoTileWidget(
                      icon: const Icon(
                        FontAwesomeIcons.envelope,
                        color: AppColors.primary,
                      ),
                      info: widget.user.email,
                    ),
                    InfoTileWidget(
                      icon: const Icon(
                        FontAwesomeIcons.mapMarkerAlt,
                        color: AppColors.primary,
                      ),
                      info: '${widget.user.city} - ${widget.user.state}',
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Text(
                  "SOBRE",
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
                      color: AppColors.primary.withOpacity(0.5),
                      blurRadius: 7,
                      spreadRadius: 1.8,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Text(
                  widget.user.description!,
                  style: AppTextStyles.cardText,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15),
                child: GestureDetector(
                  onTap: () {
                    if (isCurrentUser)
                      Navigator.pushNamed(context, '/user_posts',
                          arguments: widget.user.id);
                  },
                  child: Text(
                    "DOANDO AGORA",
                    style: AppTextStyles.bodyText,
                    textAlign: TextAlign.left,
                  ),
                ),
              ),
              const Divider(thickness: 0.5, color: AppColors.stroke),
              Container(
                margin: const EdgeInsets.only(bottom: 15),
                alignment: Alignment.topLeft,
                height: 120,
                decoration: BoxDecoration(
                  color: AppColors.backgroundColor,
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.secondary.withOpacity(0.5),
                      blurRadius: 7,
                      spreadRadius: 1.8,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: FutureBuilder<List<AnnouncementModel>>(
                    future:
                        FirestoreService().getUserAnnouncements(widget.user.id),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData)
                        return Center(child: CircularProgressIndicator());
                      final items = snapshot.data;
                      return ListView.separated(
                        itemCount: snapshot.data!.length,
                        scrollDirection: Axis.horizontal,
                        padding: EdgeInsets.all(10),
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.pushNamedAndRemoveUntil(context,
                                  '/post', ModalRoute.withName('/home'),
                                  arguments: snapshot.data![index]);
                            },
                            child: Container(
                              child: Column(
                                children: [
                                  Flexible(
                                    flex: 5,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(5),
                                            topRight: Radius.circular(5)),
                                        image: DecorationImage(
                                          image: NetworkImage(
                                              items![index].images!),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      width: 120,
                                    ),
                                  ),
                                  Expanded(
                                      child: Container(
                                    width: 120,
                                    decoration: BoxDecoration(
                                        color: AppColors.secondary,
                                        borderRadius: BorderRadius.only(
                                            bottomLeft: Radius.circular(5),
                                            bottomRight: Radius.circular(5))),
                                    child: Text(
                                      items[index].title!,
                                      style: AppTextStyles.cardTextSmall,
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.center,
                                    ),
                                  ))
                                ],
                              ),
                            ),
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) =>
                            const SizedBox(
                          width: 10,
                        ),
                      );
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
