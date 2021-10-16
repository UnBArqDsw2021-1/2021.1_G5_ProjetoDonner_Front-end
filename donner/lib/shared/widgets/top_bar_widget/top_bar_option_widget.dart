import 'package:donner/models/category_model.dart';
import 'package:donner/shared/themes/app_colors.dart';
import 'package:donner/shared/themes/app_text_styles.dart';
import 'package:flutter/material.dart';

class TopBarOptionWidget extends StatelessWidget {
  final String text;
  const TopBarOptionWidget({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: AppColors.backgroundColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.5),
            blurRadius: 3,
            spreadRadius: 0.8,
            offset: const Offset(0, 2),
          )
        ],
      ),
      child: Text(text, style: AppTextStyles.tabBarText),
    );
  }
}
