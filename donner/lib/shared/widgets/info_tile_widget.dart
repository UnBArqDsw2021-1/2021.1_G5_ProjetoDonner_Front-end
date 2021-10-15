import 'package:donner/shared/themes/app_colors.dart';
import 'package:donner/shared/themes/app_text_styles.dart';
import 'package:donner/shared/widgets/divider_vertical.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class InfoTileWidget extends StatelessWidget {
  final Icon icon;
  final String info;
  const InfoTileWidget({Key? key, required this.icon, required this.info})
      : super(key: key);

  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 5),
      decoration: const BoxDecoration(
          border: Border(
              bottom: BorderSide(
        width: 0.5,
        color: AppColors.stroke,
      ))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          icon,
          // ignore: prefer_const_constructors
          Container(
            height: 48,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: const DividerVertical(thickness: 0.5),
          ),
          Text(
            info,
            style: AppTextStyles.bodyText,
          )
        ],
      ),
    );
  }
}
