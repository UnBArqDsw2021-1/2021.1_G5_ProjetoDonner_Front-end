import 'package:donner/models/announcement_model.dart';
import 'package:donner/models/category_model.dart';
import 'package:donner/models/client_model.dart';
import 'package:donner/screens/category_screen.dart';
import 'package:donner/screens/create_post_screen.dart';
import 'package:donner/screens/edit_post_screen.dart';
import 'package:donner/screens/edit_profile_screen.dart';
import 'package:donner/screens/home_screen.dart';
import 'package:donner/screens/login_screen.dart';
import 'package:donner/screens/my_posts_screen.dart';
import 'package:donner/screens/post_screen.dart';
import 'package:donner/screens/profile_screen.dart';
import 'package:donner/screens/register_screen.dart';
import 'package:donner/screens/splash_screen.dart';
import 'package:donner/screens/user_posts.dart';
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
      // home: HomeScreen(),
      initialRoute: "/home",
      routes: {
        "/splash": (context) => const SplashScreen(),
        "/home": (context) => HomeScreen(
            user: ModalRoute.of(context)!.settings.arguments as ClientModel?),
        "/login": (context) => const LoginScreen(),
        "/register": (context) => RegisterScreen(
              user: ModalRoute.of(context)!.settings.arguments as User,
            ),
        "/post": (context) => PostScreen(
              announcement: ModalRoute.of(context)!.settings.arguments
                  as AnnouncementModel,
            ),
        "/user_posts": (context) => UserPosts(),
        "/create_post": (context) => CreatePostScreen(
              category:
                  ModalRoute.of(context)!.settings.arguments as CategoryModel?,
            ),
        "/edit_post": (context) => EditPostScreen(
              announcement: ModalRoute.of(context)!.settings.arguments
                  as AnnouncementModel,
            ),
        "/category": (context) => const CategoryScreen(),
        "/profile": (context) => ProfileScreen(
            user: ModalRoute.of(context)!.settings.arguments as ClientModel),
        "/edit_profile": (context) => EditProfileScreen(
            user: ModalRoute.of(context)!.settings.arguments as ClientModel),
      },
    );
  }
}
