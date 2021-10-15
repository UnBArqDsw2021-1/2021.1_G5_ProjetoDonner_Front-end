import 'dart:io';

import 'package:donner/models/announcement_model.dart';
import 'package:donner/shared/services/firestore_service.dart';
import 'package:donner/shared/themes/app_colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

class AnnouncementController {
  final formKey = GlobalKey<FormState>();
  AnnouncementModel? announcement;

  AnnouncementController(String owner) {
    announcement = AnnouncementModel(
      owner: owner,
      id: DateTime.now().millisecondsSinceEpoch.toString() + owner,
    );
  }

  AnnouncementController.update({required this.announcement}) {
    announcement = AnnouncementModel(
      owner: announcement!.owner,
      id: announcement!.id,
      categoryId: announcement!.categoryId,
      isDonation: announcement!.isDonation,
      images: announcement!.images,
      title: announcement!.title,
      description: announcement!.description,
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
          .child(announcement!.id!);

      final uploadTask = await storageRef
          .putFile(File(images))
          .catchError((e) => SnackBar(content: Text(e.toString())));

      final url = await storageRef
          .getDownloadURL()
          .catchError((e) => SnackBar(content: Text(e.toString())));
      onChange(images: url);
    } on FirebaseException catch (e) {
      return SnackBar(content: Text(e.toString()));
    }
  }

  Future<XFile?> chooseImage() async {
    final ImagePicker _picker = ImagePicker();
    return _picker.pickImage(source: ImageSource.gallery, imageQuality: 0, maxWidth: 400, maxHeight: 400);
  }

  Future<void> updatePost(context) async {
    await FirestoreService().updateAnnouncement(announcement: announcement!);
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text(
        "Anunciado criado com sucesso!",
        textAlign: TextAlign.center,
      ),
      elevation: 0,
      behavior: SnackBarBehavior.floating,
      width: 200,
      backgroundColor: AppColors.primary,
      duration: const Duration(
        milliseconds: 1500,
      ),
    ));

    Navigator.pushNamedAndRemoveUntil(
        context, "/home", ModalRoute.withName('/home'));
  }

  Future<void> savePost(BuildContext context) async {
    await FirestoreService().addAnnouncement(announcement!);

    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text(
        "Anunciado criado com sucesso!",
        textAlign: TextAlign.center,
      ),
      elevation: 0,
      behavior: SnackBarBehavior.floating,
      width: 200,
      backgroundColor: AppColors.primary,
      duration: const Duration(
        milliseconds: 1500,
      ),
    ));
    Navigator.pushReplacementNamed(context, "/home");
  }
}
