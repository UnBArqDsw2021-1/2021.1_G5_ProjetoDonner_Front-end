import 'package:donner/shared/themes/app_colors.dart';
import 'package:donner/shared/widgets/sidebar_widget.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primary,
      ),
      body: Container(),
      drawer: SidebarWidget()
    );
  }
}
