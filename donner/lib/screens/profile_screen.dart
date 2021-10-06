// ignore_for_file: prefer_const_constructors

import 'package:donner/shared/themes/app_colors.dart';
import 'package:donner/shared/themes/app_text_styles.dart';
import 'package:donner/shared/widgets/info_tile_widget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

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
              onTap: () {},
              child: Icon(
                FontAwesomeIcons.chevronLeft,
                color: AppColors.secondary,
                size: 30,
              )),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 20),
              child: Icon(
                FontAwesomeIcons.edit,
                color: AppColors.primary,
                size: 30,
              ),
            ),
          ]),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  alignment: Alignment.center,
                  width: 150,
                  height: 150,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: AppColors.stroke,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Lucas Gabriel Bezerra",
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
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    const InfoTileWidget(
                      icon: Icon(
                        FontAwesomeIcons.phone,
                        color: AppColors.primary,
                      ),
                      info: '90000-0000',
                    ),
                    const InfoTileWidget(
                      icon: Icon(
                        FontAwesomeIcons.envelope,
                        color: AppColors.primary,
                      ),
                      info: 'lucasgabrielbezerra@gmail.com',
                    ),
                    const InfoTileWidget(
                      icon: Icon(
                        FontAwesomeIcons.mapMarkerAlt,
                        color: AppColors.primary,
                      ),
                      info: 'Luziânia - GO',
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
                  "Eu quero trancar a matéria de ADS",
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
              ),
              Expanded(
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
            ],
          ),
        ),
      ),
    );
  }
}
