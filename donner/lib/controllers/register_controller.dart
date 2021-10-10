import 'package:donner/controllers/auth_controller.dart';
import 'package:donner/models/client_model.dart';
import 'package:donner/shared/services/firestore_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegisterController {
  final User user;
  late ClientModel client = ClientModel(
    name: user.displayName,
    email: user.email,
    photoUrl: user.photoURL,
  );
  RegisterController(this.user);

  void onChange({
    String? email,
    String? name,
    String? phone,
    String? photoUrl,
    String? description,
    String? state,
    String? city,
    List<String>? announcements,
  }) {
    client = client.copyWith(
      name: name,
      email: email,
      phone: phone,
      photoUrl: photoUrl,
      description: description,
      state: state,
      city: city,
      announcements: [],
    );
  }

  void saveUser(BuildContext context) async {
    final authController = AuthController();
    await FirestoreService().addUser(client, user.uid);
    Navigator.pushReplacementNamed(context, '/home', arguments: client);
  }
}
