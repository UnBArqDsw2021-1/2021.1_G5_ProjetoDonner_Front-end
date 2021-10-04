import 'package:donner/screens/login_screen.dart';
import 'package:donner/screens/register_screen.dart';
import 'package:flutter/material.dart';

class AppWidget extends StatelessWidget {
  AppWidget();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: const LoginScreen(),
      initialRoute: "/register",
      routes: {
        "/login": (context) => const LoginScreen(),
        "/register": (context) => const RegisterScreen(),
      },
    );
  }
}
