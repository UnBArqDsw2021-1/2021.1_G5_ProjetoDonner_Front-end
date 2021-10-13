import 'dart:io';

import 'package:donner/models/announcement_model.dart';
import 'package:donner/shared/services/firestore_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

class CreatePostController {
  final formKey = GlobalKey<FormState>();
  AnnouncementModel? announcement;

  CreatePostController(String owner) {
    announcement = AnnouncementModel(
      owner: owner,
      id: DateTime.now().millisecondsSinceEpoch.toString() + owner,
    );
  }

  String? validateTitle(String? value) =>
      value?.isEmpty ?? true ? "O título não pode ser vazio" : null;

  String? validateDescription(String? value) =>
      value?.isEmpty ?? true ? "A descrição não pode ser vazia" : null;

  String? validateDonationType(String? value) =>
      value?.isEmpty ?? true ? "É obrigatório escolher o tipo do post" : null;

  String? validateImages(String? value) => value?.isEmpty ?? true
      ? "É obrigatório adicionar ao menos uma imagem"
      : null;

  String? validateCategory(String? value) => value?.isEmpty ?? true
      ? "É obrigatório vincular o post a uma categoria"
      : null;

  void onChange({
    String? categoryId,
    String? description,
    bool? isDonation,
    String? title,
    String? images,
  }) {
    announcement = announcement!.copyWith(
      categoryId: categoryId,
      description: description,
      isDonation: isDonation,
      title: title,
      images: images,
    );
  }

  Future uploadFile(String images) async {
    try {
      final storageRef = FirebaseStorage.instance
          .ref()
          .child(announcement!.id!)
          .child(DateTime.now().millisecondsSinceEpoch.toString());

      final uploadTask = await storageRef
          .putFile(File(images))
          .catchError((e) => SnackBar(content: Text(e.toString())));

      final url = await storageRef
          .getDownloadURL()
          .catchError((e) => SnackBar(content: Text(e.toString())));
      // print("url: $url");
      onChange(images: url);
    } on FirebaseException catch (e) {
      return SnackBar(content: Text(e.toString()));
    }
  }

  Future<XFile?> chooseImage() async {
    final ImagePicker _picker = ImagePicker();
    return _picker.pickImage(source: ImageSource.gallery);
  }

  Future<void> savePost(BuildContext context) async {
    final sucess = await FirestoreService().addPost(announcement!);
    if (sucess != null)
      Navigator.pushReplacementNamed(context, "/home");
    else
      Navigator.pushReplacementNamed(context, "/home");
  }
}
