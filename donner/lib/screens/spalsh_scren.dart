import 'package:donner/controllers/auth_controller.dart';
import 'package:donner/shared/themes/app_colors.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authController = AuthController();
    authController.currentUser(context);
    return Container(
      width: 70,
      height: 70,
      color: AppColors.secondary,
      child: Center(
        child: Image.asset("assets/mini_logo_donner.png"),
      ),
    );
  }
}
