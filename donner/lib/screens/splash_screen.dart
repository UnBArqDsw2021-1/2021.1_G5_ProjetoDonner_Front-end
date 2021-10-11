import 'package:donner/shared/themes/app_colors.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 70,
      height: 70,
      color: AppColors.backgroundColor,
      child: Center(
        child: Image.asset("assets/mini_logo_donner.png"),
      ),
    );
  }
}
