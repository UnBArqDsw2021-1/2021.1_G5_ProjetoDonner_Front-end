import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:donner/models/client_model.dart';
import 'package:donner/shared/services/firestore_service.dart';

class RegisterController {
  final User user;
  ClientModel? client;
  RegisterController(this.user, {this.client}) {
    client = ClientModel(
        id: user.uid,
        name: user.displayName,
        email: user.email,
        photoUrl: user.photoURL);
  }

  void onChange({
    String? phone,
    String? description,
    String? state,
    String? city,
    List<String>? announcements,
  }) {
    client = client!.copyWith(
      phone: phone,
      description: description,
      state: state,
      city: city,
      announcements: [],
    );
  }

  void saveUser(BuildContext context) async {
    FirestoreService().addUser(client!, user.uid);
    Navigator.pushReplacementNamed(context, "/home", arguments: client);
  }

  void updateUser(BuildContext context) {
    print("Lucas Estava Errado Mesmo");
  }
}
