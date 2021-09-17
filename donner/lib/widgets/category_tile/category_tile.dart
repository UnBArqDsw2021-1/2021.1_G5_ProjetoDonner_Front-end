import 'package:donner/themes/app_colors.dart';
import 'package:donner/themes/app_text_styles.dart';
import 'package:flutter/material.dart';

class CategoryTile extends StatelessWidget {
  final IconData icon;
  final String text;

  const CategoryTile({
    Key? key,
    required this.icon,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Icon(
            icon,
            color: AppColors.primary,
          ),
          const SizedBox(
            width: 25.0,
          ),
          Text(
            text,
            style: AppTextStyles.bodyText,
          )
        ],
      ),
    );
  }
}
