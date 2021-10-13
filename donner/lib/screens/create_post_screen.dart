import 'dart:io';

import 'package:donner/controllers/create_post_controller.dart';
import 'package:donner/shared/themes/app_text_styles.dart';
import 'package:donner/shared/widgets/button_widget/factory_button.dart';
import 'package:donner/shared/widgets/input_dropdown_widget.dart';
import 'package:donner/shared/widgets/input_text_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:donner/shared/themes/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';

class CreatePostScreen extends StatefulWidget {
  User? user;
  CreatePostScreen() {
    user = FirebaseAuth.instance.currentUser;
  }

  @override
  _CreatePostScreenState createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  String? category;
  XFile? image;
  bool? isDonation;
  late CreatePostController controller;
  final FactoryButton btn = FactoryButton();
  
  @override
  void initState() {
    controller = CreatePostController(widget.user!.uid);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    double? containerHeight = 15;
    double imageHeight = 200;
    
    // Widget categoryButton = btn.getButton(
    //     text: "Categoria",
    //     color: AppColors.primary,
    //     textStyle: AppTextStyles.btnFillText,
    //     onPressed: () async {

    //     },
    //     isFill: true);

    Widget sendButton = btn.getButton(
      text: "Postar",
      color: AppColors.primary,
      textStyle: AppTextStyles.btnFillText,
      onPressed: () async {
        controller.savePost(context);
        if (image != null) {
          await controller.uploadFile(image!.path, "rrrrrrrrr");
        }
      },
      isFill: true,
    );

    // Widget customButton = title.isNotEmpty &&
    //         description.isNotEmpty &&
    //         isDonation != null &&
    //         image != null
    //     ? validCustomButton
    //     : invalidCustomButton;

    Widget imageButton = btn.getButton(
      height: imageHeight,
      text: "Escolha imagem",
      color: AppColors.backgroundColor,
      textStyle: AppTextStyles.bodyText,
      onPressed: () async {
        image = await controller.chooseImage();
        setState(() {});
      },
      icon: const Icon(
        Icons.camera_alt,
        color: AppColors.primary,
        size: 50,
      ),
      isFill: true,
    );

    Widget viewImage = image == null
        ? imageButton
        : SizedBox(
            height: imageHeight,
            child: InkWell(
              onTap: () async {
                image = await controller.chooseImage();
                setState(() {});
              },
              child: Image.file(
                File(image!.path),
              ),
            ),
          );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor,
        centerTitle: true,
        elevation: 0,
        leading: GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: const Icon(
              FontAwesomeIcons.chevronLeft,
              color: AppColors.secondary,
              size: 30,
            )),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(height: containerHeight),
              InputDropdownWidget(
                  onChanged: (value) {
                    setState(() {
                      bool isDonation =
                          value!.compareTo('Doação') != 0 ? false : true;
                      controller.onChange(isDonation: isDonation);
                    });
                  },
                  hint: "Tipo do Post",
                  items: const <String>["Doação", "Pedido"],
                  enable: true),
              Container(height: containerHeight),
              TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/category');
                    setState(() {
                      
                    });
                  },
                  child: category == null
                      ? Text("Categoria", style: AppTextStyles.inputText)
                      : Text(
                          category!,
                        )),
              Container(height: containerHeight),
              Padding(
                padding: const EdgeInsets.only(bottom: 5),
                child: Text("Foto:", style: AppTextStyles.bodyText),
              ),
              Container(
                decoration: BoxDecoration(
                    border: Border.all(
                      width: 0.5,
                      color: AppColors.stroke,
                    ),
                    borderRadius: BorderRadius.circular(15)),
                child: Center(child: viewImage),
              ),
              // Container(height: containerHeight),

              // Container(height: containerHeight),
              // Container(
              //   alignment: Alignment.topLeft,
              //   padding: const EdgeInsets.all(10),
              //   decoration: BoxDecoration(
              //     color: AppColors.backgroundColor,
              //     boxShadow: [
              //       BoxShadow(
              //         color: AppColors.primary.withOpacity(0.5),
              //         blurRadius: 7,
              //         spreadRadius: 1.8,
              //         offset: const Offset(0, 3),
              //       ),
              //     ],
              //   ),
              //   child: TextField(
              //     onChanged: (String value) {
              //       setState(() {
              //         title = value;
              //       });
              //     },
              //     decoration: InputDecoration(
              //         errorText: title.isNotEmpty
              //             ? null
              //             : "Título não pode ser vazio"),
              //   ),
              // ),
              // Container(height: containerHeight),

              // Container(height: containerHeight),
              Form(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 10, bottom: 5),
                    child: Text(
                      "Título do anúncio:",
                      style: AppTextStyles.bodyText,
                      textAlign: TextAlign.left,
                    ),
                  ),
                  InputTextWidget(
                    onChanged: (String value) {
                      setState(() {
                        controller.onChange(title: value);
                      });
                    },
                  ),
                  // TextFormField(
                  //   onChanged: (String value) {
                  //     setState(() {
                  //       description = value;
                  //     });
                  //   },
                  //   decoration: InputDecoration(
                  //       errorText: description.isNotEmpty
                  //           ? null
                  //           : "Descrição não pode ser vazia"),
                  // ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 10,
                      bottom: 5,
                    ),
                    child: Text(
                      "Descrição",
                      style: AppTextStyles.bodyText,
                      textAlign: TextAlign.left,
                    ),
                  ),
                  TextFormField(
                    onChanged: (value) {
                      setState(() {
                        controller.onChange(description: value);
                      });
                    },
                    maxLength: 500,
                    maxLines: 9,
                    decoration: InputDecoration(
                      hintStyle: AppTextStyles.inputText,
                      border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                          borderSide: BorderSide(color: AppColors.stroke)),
                      isDense: true,
                    ),
                  ),
                ],
              )),
              // Container(
              //   alignment: Alignment.topLeft,
              //   padding: const EdgeInsets.all(10),
              //   decoration: BoxDecoration(
              //     color: AppColors.backgroundColor,
              //     boxShadow: [
              //       BoxShadow(
              //         color: AppColors.primary.withOpacity(0.5),
              //         blurRadius: 7,
              //         spreadRadius: 1.8,
              //         offset: const Offset(0, 3),
              //       ),
              //     ],
              //   ),
              //   child:
              // ),
              Container(height: 5),
              Center(child: sendButton),
              Container(height: 5),
            ],
          ),
        ),
      ),
    );
  }
}
