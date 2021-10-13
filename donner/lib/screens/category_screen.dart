import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:donner/models/category_model.dart';
import 'package:donner/shared/services/firestore_service.dart';
import 'package:donner/shared/themes/app_colors.dart';
import 'package:donner/shared/themes/app_text_styles.dart';
import 'package:donner/shared/widgets/category_tile/category_tile.dart';
import 'package:flutter/material.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
          child: FutureBuilder<QuerySnapshot>(
            future: FirestoreService().getCategories(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        Navigator.pop(
                            context,
                            CategoryModel.fromDocument(
                                snapshot.data!.docs[index]));
                      },
                      child: Column(
                        children: [
                          CategoryTile(
                              category: CategoryModel.fromDocument(
                            snapshot.data!.docs[index],
                          )),
                          const Divider(
                            color: AppColors.stroke,
                          )
                        ],
                      ),
                    );
                  },
                );
              }
            },
          )),
    );
  }
}
