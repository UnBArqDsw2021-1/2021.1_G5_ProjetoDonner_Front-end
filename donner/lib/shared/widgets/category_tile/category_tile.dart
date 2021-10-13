import 'package:donner/models/category_model.dart';
import 'package:donner/shared/themes/app_colors.dart';
import 'package:donner/shared/themes/app_text_styles.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CategoryTile extends StatelessWidget {
  final CategoryModel category;

  const CategoryTile({
    Key? key,
    required this.category, 
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          ImageIcon(
            NetworkImage(category.icon!),
            color: AppColors.primary,
          ),
          const SizedBox(
            width: 25.0,
          ),
          Text(
            category.category!,
            style: AppTextStyles.bodyText,
          )
        ],
      ),
    );
  }
}