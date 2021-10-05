import 'package:donner/controllers/login_controller.dart';
import 'package:donner/shared/themes/app_colors.dart';
import 'package:donner/shared/themes/app_text_styles.dart';
import 'package:donner/shared/widgets/button_widget/factory_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  LoginController controller = LoginController();
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
                  height: size.height * 0.45,
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
                  FutureBuilder(
                      future: controller.initializeFirebase(),
                      builder: (context, snapshot) {
                        return Container(
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
                                final User? user = await controller
                                    .signInWithGoogle(context: context);

                                if (user != null) {
                                  //Mudar o nome da função
                                  if (await controller.signUp(user.uid)) {
                                    await Navigator.pushReplacementNamed(
                                      context,
                                      "/home",
                                    );
                                  }

                                  await Navigator.pushReplacementNamed(
                                    context,
                                    "/register",
                                    arguments: user,
                                  );
                                }
                              },
                            ));
                      }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
