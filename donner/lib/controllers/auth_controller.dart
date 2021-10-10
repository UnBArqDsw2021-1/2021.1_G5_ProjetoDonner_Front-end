import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:donner/models/client_model.dart';
import 'package:donner/shared/services/firestore_service.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthController {
  String? _userId;
  static final AuthController _authController = AuthController._internal();

  factory AuthController() {
    return _authController;
  }

  AuthController._internal();

  get userId => _userId;

  void setUser(BuildContext context, DocumentSnapshot? userDoc) {
    if (userDoc != null) {
      saveUser(userDoc.id);

      Navigator.pushReplacementNamed(context, '/home',
          arguments: ClientModel.fromSnapshot(userDoc));
    } else {
      Navigator.pushReplacementNamed(context, '/home');
    }
  }

  Future<void> saveUser(String userId) async {
    final instance = await SharedPreferences.getInstance();
    await instance.setString("user", userId);
    return;
  }

  Future<void> currentUser(BuildContext context) async {
    final instance = await SharedPreferences.getInstance();
    // await Future.delayed(const Duration(seconds: 2));

    if (instance.containsKey("user")) {
      final json = instance.get("user") as String;
      final userDoc = await FirestoreService().findUser(json);
      setUser(context, userDoc);
    } else {
      setUser(context, null);
    }
    return;
  }
  // Future<ClientModel?> userAtual() async {
  //   final instance = await SharedPreferences.getInstance();
  //   if (instance.containsKey("user")) {
  //     final json = instance.get("user") as String;
  //     _userId = json;
  //   } else {}
  //   return _user;
  // }

}
