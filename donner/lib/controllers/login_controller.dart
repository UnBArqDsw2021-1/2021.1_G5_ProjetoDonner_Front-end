import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/widgets.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/material.dart';

import 'auth_controller.dart';

class LoginController {
  // acho que essa parte de initialize vai ser removida
  Future<FirebaseApp> initializeFirebase(
      {required BuildContext context}) async {
    FirebaseApp firebaseApp = await Firebase.initializeApp();

    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      await Navigator.pushReplacementNamed(context, "/home");
    }
    return firebaseApp;
  }

  Future<User?> signInWithGoogle({required BuildContext context}) async {
    FirebaseAuth auth = FirebaseAuth.instance;
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
            await auth.signInWithCredential(credential);

        user = userCredential.user;

        return user;
      }
    } on FirebaseAuthException catch (err) {
      final snackBar = SnackBar(
        content: Text(err.toString()),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  //Mudar nome da func
  Future<bool> alreadySignUp(String uid) async {
    final userRef =
        await FirebaseFirestore.instance.collection('users').doc(uid).get();
    if (userRef.exists) {
      return true;
      // Colocar pra pegar usuario do shared preferences
    }
    return false;
  }

  Future<void> login(context) async {
    final auth = AuthController();
    await auth.currentUser(context);
  }
}
