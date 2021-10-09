// ignore_for_file: prefer_const_constructors

import 'package:donner/models/client_model.dart';
import 'package:donner/shared/themes/app_colors.dart';
import 'package:donner/shared/themes/app_text_styles.dart';
import 'package:donner/shared/widgets/info_tile_widget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ProfileScreen extends StatelessWidget {
  final ClientModel user;
  const ProfileScreen({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Color> colorCodes = [
      AppColors.primary,
      AppColors.secondary,
      AppColors.stroke,
      AppColors.primary,
      AppColors.secondary,
      AppColors.stroke,
    ];
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Icon(
                FontAwesomeIcons.chevronLeft,
                color: AppColors.secondary,
                size: 30,
              )),
              //Verificar se o param user é igual ao user logado
          actions: const [
            Padding(
              padding: EdgeInsets.only(right: 20),
              child: Icon(
                FontAwesomeIcons.edit,
                color: AppColors.primary,
                size: 30,
              ),
            ),
          ]),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
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
                      fit: BoxFit.fill,
                      image: NetworkImage(user.photoUrl!),
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
                      user.name,
                      style: AppTextStyles.bodyText,
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: const Icon(
                        Icons.logout,
                        color: AppColors.primary,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 30, left: 10, right: 10),
                child: Wrap(
                  runSpacing: 10,
                  children: [
                    InfoTileWidget(
                      icon: Icon(
                        FontAwesomeIcons.phone,
                        color: AppColors.primary,
                      ),
                      info: user.phone!,
                    ),
                    InfoTileWidget(
                      icon: Icon(
                        FontAwesomeIcons.envelope,
                        color: AppColors.primary,
                      ),
                      info: user.email,
                    ),
                    InfoTileWidget(
                      icon: Icon(
                        FontAwesomeIcons.mapMarkerAlt,
                        color: AppColors.primary,
                      ),
                      info: '${user.city} - ${user.state}',
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
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Text(
                  user.description!,
                  style: AppTextStyles.cardText,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15),
                child: Text(
                  "DOANDO AGORA",
                  style: AppTextStyles.bodyText,
                  textAlign: TextAlign.left,
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
                child: SizedBox(
                height: 125,
                child: ListView.separated(
                  itemCount: colorCodes.length,
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.all(10),
                  itemBuilder: (context, index) {
                    return Container(
                      width: 120,
                      color: colorCodes[index],
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) =>
                      const SizedBox(
                    width: 15,
                  ),
                ),
              ),
              ),
              
            ],
          ),
        ),
      ),
    );
  }
}
