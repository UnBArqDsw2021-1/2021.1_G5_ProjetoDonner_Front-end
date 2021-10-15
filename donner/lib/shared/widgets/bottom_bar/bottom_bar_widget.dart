import 'package:donner/shared/themes/app_colors.dart';
import 'package:flutter/material.dart';

class BottomBarWidget extends StatelessWidget {
  final VoidCallback? onTapPerson;
  final VoidCallback? onTapHome;
  const BottomBarWidget({Key? key, this.onTapPerson, this.onTapHome})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.primary,
      height: 50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          GestureDetector(
            onTap: onTapPerson,
            child: const Icon(
              Icons.person_outline,
              color: AppColors.backgroundColor,
              size: 35,
            ),
          ),
          GestureDetector(
            onTap: onTapHome,
            child: const Icon(
              Icons.home_outlined,
              size: 35,
              color: AppColors.backgroundColor,
            ),
          )
        ],
      ),
    );
  }
}
