import 'dart:io';

import 'package:donner/controllers/create_post_controller.dart';
import 'package:donner/models/category_model.dart';
import 'package:donner/shared/themes/app_colors.dart';
import 'package:donner/shared/themes/app_text_styles.dart';
import 'package:donner/shared/widgets/button_widget/factory_button.dart';
import 'package:donner/shared/widgets/input_dropdown_widget.dart';
import 'package:donner/shared/widgets/input_text_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';

class CreatePostScreen extends StatefulWidget {
  User? user;
  CategoryModel? category;
  CreatePostScreen({Key? key, this.category}) : super(key: key) {
    user = FirebaseAuth.instance.currentUser;
  }

  @override
  _CreatePostScreenState createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  XFile? image;
  bool? isDonation;
  late CreatePostController controller;
  bool loading = false;
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

    Widget sendButton = btn.getButton(
      onPressed: () async {
        final form = controller.formKey.currentState;
        if (form!.validate() && image != null && widget.category != null) {
          setState(() {
            loading = true;
          });
          await controller.uploadFile(image!.path);
          await controller.savePost(context);
        } else {
          if (widget.category == null) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(controller.validateCategory(null)!),
            ));
          }
          if (image == null) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(controller.validateImages(null)!),
            ));
          }
        }
      },
      text: "Postar",
      color: AppColors.primary,
      textStyle: AppTextStyles.btnFillText,
      isFill: true,
    );

    Widget imageButton = btn.getButton(
      onPressed: () async {
        image = await controller.chooseImage();
        setState(() {});
      },
      height: imageHeight,
      text: "Escolha imagem",
      color: AppColors.backgroundColor,
      textStyle: AppTextStyles.bodyText,
      icon: const Icon(
        Icons.camera_alt,
        color: AppColors.primary,
        size: 40,
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
              if (!loading) Navigator.of(context).pop();
            },
            child: const Icon(
              FontAwesomeIcons.chevronLeft,
              color: AppColors.secondary,
              size: 30,
            )),
      ),
      body: Stack(children: [
        loading
            ? Container(
                color: Colors.transparent,
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              )
            : SingleChildScrollView(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Form(
                    key: controller.formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(height: containerHeight),
                        InputDropdownWidget(
                            validator: controller.validateDonationType,
                            onChanged: (value) {
                              setState(() {
                                bool isDonation =
                                    value!.compareTo('Doação') != 0
                                        ? false
                                        : true;
                                controller.onChange(isDonation: isDonation);
                              });
                            },
                            hint: "Tipo do Post",
                            items: const <String>["Doação", "Pedido"],
                            enable: true),
                        Container(height: containerHeight),
                        Container(
                          height: 40,
                          decoration: BoxDecoration(
                            border: Border.all(width: 0.5),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: TextButton(
                              onPressed: () async {
                                final result = await Navigator.pushNamed(
                                    context, '/category') as CategoryModel?;
                                setState(() {
                                  if (result != null) {
                                    widget.category = result;
                                    controller.onChange(
                                        categoryId: widget.category!.id);
                                  }
                                });
                              },
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  widget.category == null
                                      ? Text("Categoria",
                                          style: AppTextStyles.inputText)
                                      : Text(
                                          widget.category!.category!,
                                          style: AppTextStyles.bodyText,
                                        ),
                                  const Icon(
                                    Icons.expand_more_outlined,
                                    color: AppColors.primary,
                                  )
                                ],
                              )),
                        ),
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
                        Padding(
                          padding: const EdgeInsets.only(top: 10, bottom: 5),
                          child: Text(
                            "Título do anúncio:",
                            style: AppTextStyles.bodyText,
                            textAlign: TextAlign.left,
                          ),
                        ),
                        InputTextWidget(
                          validator: controller.validateTitle,
                          onChanged: (String value) {
                            setState(() {
                              controller.onChange(title: value);
                            });
                          },
                        ),
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
                          validator: controller.validateDescription,
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
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5)),
                                borderSide:
                                    BorderSide(color: AppColors.stroke)),
                            isDense: true,
                          ),
                        ),
                        Container(height: 5),
                        Center(child: sendButton),
                        Container(height: 5),
                      ],
                    ),
                  ),
                ),
              ),
      ]),
    );
  }
}
