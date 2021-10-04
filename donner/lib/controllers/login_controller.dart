import 'package:donner/models/client_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/widgets.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/material.dart';

class LoginController {
  Future<FirebaseApp> initializeFirebase() async {
    FirebaseApp firebaseApp = await Firebase.initializeApp();

    return firebaseApp;
  }

  Future<void> signInWithGoogle({required BuildContext context}) async {
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

        // client.copyWith(
        //     phone: user!.displayName,
        //     photoUrl: user.photoURL,
        //     email: user.email!,
        //     );

      }
    } on FirebaseAuthException catch (err) {
      final snackBar = SnackBar(
        content: Text(err.toString()),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }
}
