import 'package:donner/models/client_model.dart';
import 'package:donner/shared/services/firestore_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/material.dart';

class Authentication {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> signInWithGoogle({required BuildContext context}) async {
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

        signUpOrSignIn(user, context);
      }
    } on FirebaseAuthException catch (err) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(err.toString()),
      ));
    }
  }

  Future<void> setUser(BuildContext context, ClientModel? user) async {
    if (user != null) {
    } else {
      Navigator.pushReplacementNamed(context, '/home');
    }
  }

  Future<ClientModel?> getUserInfo() async {
    ClientModel? client;

    if (_auth.currentUser != null) {
      final userDoc = await FirestoreService().findUser(_auth.currentUser!.uid);
      client = ClientModel.fromSnapshot(userDoc);
    }
    return client;
  }

  Future<void> signUpOrSignIn(User? user, BuildContext context) async {
    if (user != null) {
      final userDoc = await FirestoreService().findUser(user.uid);
      if (userDoc.exists) {
        await Navigator.pushReplacementNamed(
          context,
          "/home",
          arguments: ClientModel.fromSnapshot(userDoc),
        );
      } else {
        await Navigator.pushReplacementNamed(
          context,
          "/register",
          arguments: user,
        );
      }
    }
  }

  Future<void> signOut(BuildContext context) async {
    final GoogleSignIn googleSignIn = GoogleSignIn();
    try {
      await googleSignIn.signOut();
      await _auth.signOut();
      Navigator.pushReplacementNamed(context, '/home');
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Error signing out. Try again.'),
        ),
      );
    }
  }
}
