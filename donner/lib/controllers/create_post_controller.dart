import 'dart:io';

import 'package:donner/models/announcement_model.dart';
import 'package:donner/shared/services/firestore_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';


class CreatePostController {
  AnnouncementModel? announcement;

  CreatePostController(String owner){
    announcement = AnnouncementModel(owner: owner);
  }
  void onChange({
    String? categoryId,
    String? description,
    String? id,
    bool? isDonation,
    String? title,
    String? images,
  }) {
    announcement = announcement!.copyWith(
      categoryId: categoryId,
      description: description,
      id: id,
      isDonation: isDonation,
      title: title,
      images: images,
    );
  }

  Future uploadFile(String images, String id) async {
    try {
      final storageRef = FirebaseStorage.instance
          .ref()
          .child(id)
          .child(DateTime.now().millisecondsSinceEpoch.toString());

      final uploadTask = await storageRef.putFile(File(images)).catchError((e)=> SnackBar(content: Text(e.toString())));
      
      final url = await storageRef.getDownloadURL().catchError((e)=> SnackBar(content: Text(e.toString())));
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

  void savePost(BuildContext context) async {
    print(announcement.toString());
    // FirestoreService().addPost(announcement!);
    // Navigator.pushReplacementNamed(context, "/home");
  }
}
