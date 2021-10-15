import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:donner/models/client_model.dart';
import 'package:donner/shared/services/firestore_service.dart';

class ProfileController {
  final formKey = GlobalKey<FormState>();
  final User? user;
  ClientModel? client;

  ProfileController(this.user, {this.client}) {
    client = ClientModel(
        id: user!.uid,
        name: user!.displayName,
        email: user!.email,
        photoUrl: user!.photoURL);
  }

  ProfileController.update({required this.client, this.user}) {
    client = ClientModel(
        id: client!.id,
        name: client!.name,
        email: client!.email,
        photoUrl: client!.photoUrl,
        phone: client!.phone,
        description: client!.description,
        state: client!.state,
        city: client!.city,
        announcements: client!.announcements);
  }

  String? validatePhone(String? value) {
    if (value!.isEmpty) {
      return "O número de telefone não pode ser vazio";
    } else if (value.length != 13) {
      return "O Telefone é inválido";
    }

    return null;
  }

  void onChange({
    String? photoUrl,
    String? phone,
    String? description,
    String? state,
    String? city,
    List<String>? announcements,
  }) {
    client = client!.copyWith(
      photoUrl: photoUrl,
      phone: phone,
      description: description,
      state: state,
      city: city,
      announcements: [],
    );
  }

  void saveUser(BuildContext context) async {
    FirestoreService().addUser(client!, user!.uid);
    Navigator.pushReplacementNamed(context, "/home", arguments: client);
  }

  Future<ClientModel> updateUser() async {
    await FirestoreService().updateUser(user: client!);
    return client!;
  }

  void registerUser(BuildContext context, bool newUser) async {
    final form = formKey.currentState;
    if (form!.validate()) {
      if (newUser) {
        saveUser(context);
      } else {
        final user = await updateUser();
        Navigator.pushNamedAndRemoveUntil(
            context, "/home", ModalRoute.withName('/home'),
            arguments: user);
      }
    }
  }

  Future uploadFile(String image, String userId) async {
    try {
      final storageRef = FirebaseStorage.instance
          .ref()
          .child('usersImage')
          .child('$userId.png');

      final uploadTask = storageRef.putFile(File(image));
      uploadTask.whenComplete(
          () => const SnackBar(content: Text("Upload realizado com Sucesso")));
      final url = await storageRef.getDownloadURL();
      onChange(photoUrl: url);
    } on FirebaseException catch (e) {
      return SnackBar(content: Text(e.toString()));
    }
  }
}
