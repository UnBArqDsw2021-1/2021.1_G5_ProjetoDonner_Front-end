import 'dart:io';

import 'package:donner/shared/themes/app_text_styles.dart';
import 'package:donner/shared/widgets/button_widget/factory_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:donner/shared/themes/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class PostsEditor extends StatefulWidget {
  User? user;
  PostsEditor() {
    user = FirebaseAuth.instance.currentUser;
  }

  @override
  _PostsEditorState createState() => _PostsEditorState();
}

class _PostsEditorState extends State<PostsEditor> {
  String title = "";
  String description = "";
  XFile? image;

  final FactoryButton btn = FactoryButton();

  Future<XFile?> chooseImage() async {
    final ImagePicker _picker = ImagePicker();

    return _picker.pickImage(source: ImageSource.gallery);
  }

  @override
  Widget build(BuildContext context) {
    Widget validCustomButton = btn.getButton(
        text: "Enviar",
        color: AppColors.primary,
        textStyle: AppTextStyles.btnFillText,
        onPressed: () => print("OK"),
        isFill: true);

    Widget invalidCustomButton = btn.getButton(
        text: "Enviar",
        color: AppColors.backgroundColor,
        textStyle: AppTextStyles.bodyText,
        onPressed: () {},
        isFill: true);

    Widget customButton = title.isNotEmpty && description.isNotEmpty
        ? validCustomButton
        : invalidCustomButton;

    Widget imageButton = btn.getButton(
        height: 100,
        text: "Escolha imagem",
        color: AppColors.backgroundColor,
        textStyle: AppTextStyles.bodyText,
        onPressed: () async {
          image = await chooseImage();
          setState(() {});
        },
        icon: const Icon(Icons.camera_alt),
        isFill: true);

    Widget viewImage = image == null
        ? imageButton
        : SizedBox(
            height: 200,
            child: InkWell(
                onTap: () async {
                  image = await chooseImage();
                  setState(() {});
                },
                child: Image.file(File(image!.path))),
          );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Container(height: 10),
              viewImage,
              Container(height: 10),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Text(
                  "Título do anúncio",
                  style: AppTextStyles.bodyText,
                  textAlign: TextAlign.left,
                ),
              ),
              Container(height: 10),
              Container(
                alignment: Alignment.topLeft,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: AppColors.backgroundColor,
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primary.withOpacity(0.5),
                      blurRadius: 7,
                      spreadRadius: 1.8,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: TextField(
                  onChanged: (String value) {
                    setState(() {
                      title = value;
                    });
                  },
                  decoration: InputDecoration(
                      errorText: title.isNotEmpty
                          ? null
                          : "Título não pode ser vazio"),
                ),
              ),
              Container(height: 10),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Text(
                  "Descrição",
                  style: AppTextStyles.bodyText,
                  textAlign: TextAlign.left,
                ),
              ),
              Container(height: 10),
              Container(
                alignment: Alignment.topLeft,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: AppColors.backgroundColor,
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primary.withOpacity(0.5),
                      blurRadius: 7,
                      spreadRadius: 1.8,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: TextField(
                  onChanged: (String value) {
                    setState(() {
                      description = value;
                    });
                  },
                  decoration: InputDecoration(
                      errorText: description.isNotEmpty
                          ? null
                          : "Descrição não pode ser vazia"),
                ),
              ),
              Container(height: 10),
              customButton,
            ],
          ),
        ),
      ),
    );
  }
}
