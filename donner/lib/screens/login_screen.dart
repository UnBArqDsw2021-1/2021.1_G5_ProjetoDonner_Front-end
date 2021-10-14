import 'package:donner/controllers/authentication.dart';
import 'package:donner/shared/themes/app_colors.dart';
import 'package:donner/shared/themes/app_text_styles.dart';
import 'package:donner/shared/widgets/button_widget/factory_button.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/services.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  Authentication controller = Authentication();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final btn = FactoryButton();
    return Scaffold(
      backgroundColor: AppColors.secondary,
      body: SizedBox(
        width: size.width,
        height: size.height,
        child: Column(
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(50),
                        bottomRight: Radius.circular(50)),
                    color: AppColors.backgroundColor,
                  ),
                  width: size.width,
                  height: size.height * 0.40,
                ),
                Center(
                  child: Image.asset(
                    'assets/logo_donner.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 20),
              child: Column(
                children: [
                  Text(
                    "Solidariedade não\n é doar o que\n sobra, é dar o que\n falta",
                    style: AppTextStyles.donnerText,
                    textAlign: TextAlign.center,
                  ),
                  Container(
                      margin: const EdgeInsets.symmetric(vertical: 40),
                      child: btn.getButton(
                        height: 50,
                        width: 310,
                        icon: const Icon(
                          FontAwesomeIcons.google,
                          color: AppColors.primary,
                        ),
                        text: 'Entrar com a conta Google',
                        color: AppColors.backgroundColor,
                        textStyle: AppTextStyles.bodyText,
                        isFill: true,
                        onPressed: () async {
                          await controller.signInWithGoogle(context: context);
                        },
                      ))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
