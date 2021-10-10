import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'auth_controller.dart';

class LoginController {
  // acho que essa parte de initialize vai ser removida
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Future<void> initializeFirebase({required BuildContext context}) async {
  //   User? user = _auth.currentUser;

  //   if (user != null) {
  //     await Navigator.pushReplacementNamed(context, "/home");
  //   }
  //   return;
  // }

  Future<User?> signInWithGoogle({required BuildContext context}) async {
    // final SharedPreferences sharedInstance =
    //     await SharedPreferences.getInstance();
    User? user;

    try {
      final GoogleSignIn _googleSignIn = GoogleSignIn();

      final GoogleSignInAccount? _googleSignInAccount =
          await _googleSignIn.signIn();

      if (_googleSignInAccount != null) {
        final GoogleSignInAuthentication _googleSignInAuthentication =
            await _googleSignInAccount.authentication;

        final AuthCredential credential = GoogleAuthProvider.credential(
            idToken: _googleSignInAuthentication.idToken,
            accessToken: _googleSignInAuthentication.accessToken);
        final UserCredential userCredential =
            await _auth.signInWithCredential(credential);

        user = userCredential.user;
        final authController = AuthController();
        authController.saveUser(user!.uid);
        print('Singleton:' + authController.numb.toString());

        return user;
      }
    } on FirebaseAuthException catch (err) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(err.toString()),
      ));
    }
  }

  //Corrigir

  Future<void> signOut(BuildContext context) async {
    final GoogleSignIn googleSignIn = GoogleSignIn();
    final SharedPreferences sharedInstance =
        await SharedPreferences.getInstance();

    try {
      await googleSignIn.signOut();
      await _auth.signOut();
      await sharedInstance.remove('user');
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Error signing out. Try again.'),
        ),
      );
    }
  }
}
