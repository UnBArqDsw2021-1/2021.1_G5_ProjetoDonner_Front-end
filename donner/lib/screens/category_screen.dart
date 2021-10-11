import 'package:donner/shared/themes/app_colors.dart';
import 'package:donner/shared/themes/app_text_styles.dart';
import 'package:donner/shared/widgets/category_tile/category_tile.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Widget> listWidgets = [
      const CategoryTile(icon: FontAwesomeIcons.tv, text: "Eletrodomésticos"),
      Divider(color: AppColors.stroke),
      const CategoryTile(icon: FontAwesomeIcons.coffee, text: "Alimentos"),
      Divider(color: AppColors.stroke),
      const CategoryTile(icon: Icons.checkroom, text: "Roupas"),
      Divider(color: AppColors.stroke),
      const CategoryTile(icon: FontAwesomeIcons.socks, text: "Calçados"),
      Divider(color: AppColors.stroke),
      const CategoryTile(icon: FontAwesomeIcons.book, text: "Livros"),
      Divider(color: AppColors.stroke),
      const CategoryTile(
          icon: FontAwesomeIcons.guitar, text: "Instrumentos Musicais"),
      Divider(color: AppColors.stroke),
    ];
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Categoria",
          style: AppTextStyles.appBarText,
        ),
        backgroundColor: AppColors.primary,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: listWidgets,
        ),
      ),
    );
  }
}
