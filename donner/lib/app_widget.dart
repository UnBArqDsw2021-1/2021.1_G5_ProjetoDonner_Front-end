import 'package:donner/screens/home_screen.dart';
import 'package:donner/screens/login_screen.dart';
import 'package:donner/screens/register_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AppWidget extends StatelessWidget {
  AppWidget();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Donner',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const LoginScreen(),
      initialRoute: "/register",
      routes: {
        "/login": (context) => const LoginScreen(),
        "/register": (context) => RegisterScreen(
              user: ModalRoute.of(context)!.settings.arguments as User,
            ),
        "/home": (context) => const HomeScreen(),
      },
    );
  }
}
