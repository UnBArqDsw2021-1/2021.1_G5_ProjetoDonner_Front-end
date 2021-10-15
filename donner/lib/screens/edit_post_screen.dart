import 'dart:io';

import 'package:donner/controllers/announcement_controller.dart';
import 'package:donner/models/announcement_model.dart';

import 'package:donner/shared/themes/app_colors.dart';
import 'package:donner/shared/themes/app_text_styles.dart';
import 'package:donner/shared/widgets/button_widget/factory_button.dart';
import 'package:donner/shared/widgets/input_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';

class EditPostScreen extends StatefulWidget {
  final AnnouncementModel announcement;
  EditPostScreen({Key? key, required this.announcement})
      : super(key: key) {}

  @override
  _EditPostScreenState createState() => _EditPostScreenState();
}

class _EditPostScreenState extends State<EditPostScreen> {
  XFile? image;
  bool? isDonation;
  late AnnouncementController controller;
  bool loading = false;
  final FactoryButton btn = FactoryButton();
  @override
  void initState() {
    controller =
        AnnouncementController.update(announcement: widget.announcement);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double? containerHeight = 15;
    double imageHeight = 200;

    Widget updateButton = btn.getButton(
      onPressed: () async {
        final form = controller.formKey.currentState;
        if (form!.validate()) {
          if (image != null) await controller.uploadFile(image!.path);
          await controller.updatePost(context);
        }
      },
      text: "Atualizar",
      color: AppColors.primary,
      textStyle: AppTextStyles.btnFillText,
      isFill: true,
    );

    Widget viewImage = SizedBox(
      height: imageHeight,
      child: InkWell(
        onTap: () async {
          image = await controller.chooseImage();
          setState(() {});
        },
        child: image == null
            ? Image.network(
                widget.announcement.images!,
                fit: BoxFit.cover,
              )
            : Image.file(File(image!.path)),
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
          ),
        ),
      ),
      body: Stack(
        children: [
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
                          Padding(
                            padding: const EdgeInsets.only(bottom: 5, top: 15),
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
                            initialValue: widget.announcement.title,
                            onChanged: (String value) {
                              setState(
                                () {
                                  controller.onChange(title: value);
                                },
                              );
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
                              setState(
                                () {
                                  controller.onChange(description: value);
                                },
                              );
                            },
                            initialValue: widget.announcement.description,
                            maxLength: 500,
                            maxLines: 9,
                            decoration: InputDecoration(
                              hintStyle: AppTextStyles.inputText,
                              border: const OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(5),
                                ),
                                borderSide: BorderSide(
                                  color: AppColors.stroke,
                                ),
                              ),
                              isDense: true,
                            ),
                          ),
                          Container(height: 5),
                          Center(child: updateButton),
                          Container(height: 5),
                        ],
                      ),
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}
