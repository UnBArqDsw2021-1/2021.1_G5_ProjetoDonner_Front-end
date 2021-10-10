import 'package:donner/models/client_model.dart';
import 'package:donner/shared/themes/app_colors.dart';
import 'package:donner/shared/widgets/sidebar_widget.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  final ClientModel? user;
  const HomeScreen({Key? key, this.user}) : super(key: key);

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
      drawer: SidebarWidget(
        user: widget.user,
      ),
    );
  }
}
