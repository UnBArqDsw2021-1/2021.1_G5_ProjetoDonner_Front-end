import 'package:donner/controllers/authentication.dart';
import 'package:donner/models/client_model.dart';
import 'package:donner/shared/themes/app_colors.dart';
import 'package:donner/shared/widgets/sidebar_widget.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  ClientModel? user;
  HomeScreen({Key? key, this.user}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primary,
      ),
      body: Container(),
      drawer: FutureBuilder<ClientModel?>(future: Authentication().getUserInfo() ,builder: (context, snap){
        if(snap.hasError){
          return SnackBar(
            content: Text(snap.error.toString()),
          );
        }else{
           return SidebarWidget(
            user: snap.data,
          );
        }
      },)
    );
  }
}
