import 'package:donner/models/client_model.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthController {
  ClientModel? _user;

  get user => _user;

  void setUser(BuildContext context, ClientModel? user) {
    if (user != null) {
      saveUser(user);
      Navigator.pushReplacementNamed(context, '/home', arguments: user);
    }else{
      Navigator.pushReplacementNamed(context, '/home');
    }
  }

  Future<void> saveUser(ClientModel user) async {
    final instance = await SharedPreferences.getInstance();
    await instance.setString("user", user.toJson());
    return;
  }

  Future<void> currentUser(BuildContext context) async {
    final instance = await SharedPreferences.getInstance();
    // await Future.delayed(const Duration(seconds: 2));

    if (instance.containsKey("user")) {
      final json = instance.get("user") as String;
      setUser(context, ClientModel.fromJson(json));
      _user = ClientModel.fromJson(json);
    } else {
      setUser(context, null);
    }
    return;
  }

  Future<ClientModel?> userAtual() async {
    final instance = await SharedPreferences.getInstance();
    if (instance.containsKey("user")) {
      final json = instance.get("user") as String;
      _user = ClientModel.fromJson(json);
    } else {}
    return _user;
  }
}
