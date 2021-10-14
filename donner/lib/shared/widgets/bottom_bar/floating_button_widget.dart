import 'package:donner/shared/themes/app_colors.dart';
import 'package:flutter/material.dart';

class FloatingButton extends StatelessWidget {
  final VoidCallback onPressed;
  const FloatingButton({Key? key, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: onPressed,
      backgroundColor: Colors.transparent,
      elevation: 0,
      child: Container(
        height: 50,
        width: 50,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: AppColors.backgroundColor,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.5),
              blurRadius: 7,
              spreadRadius: 1.8,
              offset: const Offset(0, -0.1),
            ),
          ],
        ),
        child: const Icon(
          Icons.add_rounded,
          size: 40,
          color: AppColors.secondary,
        ),
      ),
    );
  }
}
