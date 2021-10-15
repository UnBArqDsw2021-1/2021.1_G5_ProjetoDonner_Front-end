import 'dart:io';

import 'package:donner/controllers/profile_controller.dart';
import 'package:donner/models/client_model.dart';
import 'package:donner/shared/themes/app_colors.dart';
import 'package:donner/shared/themes/app_text_styles.dart';
import 'package:donner/shared/widgets/button_widget/custom_text_button.dart';
import 'package:donner/shared/widgets/input_dropdown_widget.dart';
import 'package:donner/shared/widgets/input_text_widget.dart';
import 'package:estados_municipios/estados_municipios.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class EditProfileScreen extends StatefulWidget {
  final ClientModel user;
  const EditProfileScreen({Key? key, required this.user}) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late ProfileController controller;
  EstadosMunicipiosController local = EstadosMunicipiosController();
  List<String> states = [];
  List<String> cities = [];
  String? state;
  String? city;
  XFile? _image;
  var maskFormatter = MaskTextInputFormatter(
      mask: '## #####-####', filter: {"#": RegExp(r'[0-9]')});

  @override
  void initState() {
    controller = ProfileController.update(client: widget.user);
    state = widget.user.state;
    city = widget.user.city;
    listCities(state!);
    listStates();

    super.initState();
  }

  void listStates() async {
    var allStates = await EstadosMunicipiosController().buscaTodosEstados();

    for (var s in allStates) {
      states.add(s.sigla!);
    }
    states.sort((a, b) => a.compareTo(b));
  }

  void listCities(String state) async {
    cities.clear();
    var citiesFromState = await local.buscaMunicipiosPorEstado(state);

    for (var c in citiesFromState) {
      cities.add(c.nome!);
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
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
            children: [
              Center(
                child: Stack(children: [
                  Container(
                    width: 150.0,
                    height: 150.0,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: (_image == null)
                            ? NetworkImage(widget.user.photoUrl!)
                            : FileImage(File(_image!.path)) as ImageProvider,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 5,
                    child: GestureDetector(
                      onTap: () async {
                        final image = await ImagePicker()
                            .pickImage(source: ImageSource.gallery)
                            .then((file) {
                          setState(() {
                            _image = file;
                          });
                        });
                      },
                      child: Container(
                          alignment: Alignment.center,
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle, color: AppColors.primary),
                          child: Icon(
                            FontAwesomeIcons.camera,
                            color: AppColors.backgroundColor,
                            size: 20,
                          )),
                    ),
                  ),
                ]),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Center(
                  child: Text(
                    widget.user.name,
                    style: AppTextStyles.bodyText,
                  ),
                ),
              ),
              Form(
                key: controller.formKey,
                child: Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Wrap(
                    runSpacing: 10,
                    children: [
                      InputTextWidget(
                        icon: const Icon(
                          Icons.phone,
                          color: AppColors.primary,
                        ),
                        initialValue: widget.user.phone!,
                        keyboardType: TextInputType.phone,
                        validator: controller.validatePhone,
                        formatter: [maskFormatter],
                        onChanged: (value) {
                          controller.onChange(phone: value);
                        },
                      ),
                      Row(
                        children: [
                          const Icon(
                            FontAwesomeIcons.mapMarkerAlt,
                            color: AppColors.primary,
                            size: 30,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 5),
                            child: SizedBox(
                                width: size.width * 0.25,
                                child: InputDropdownWidget(
                                  onChanged: (value) {
                                    setState(() {
                                      state = value;
                                      controller.onChange(state: value);
                                      city = null;
                                      listCities(state!);
                                    });
                                  },
                                  hint: "UF",
                                  items: states,
                                  enable: true,
                                  currentItem: widget.user.state!,
                                )),
                          ),
                          const Padding(padding: EdgeInsets.only(left: 10)),
                          Expanded(
                              child: InputDropdownWidget(
                            onChanged: (value) {
                              setState(() {
                                controller.onChange(city: value);
                                city = value;
                              });
                            },
                            hint: "Cidade",
                            items: cities,
                            state: state,
                            enable: state != null ? true : false,
                            currentItem: city,
                          )),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Text(
                  "SOBRE",
                  style: AppTextStyles.bodyText,
                  textAlign: TextAlign.left,
                ),
              ),
              const Divider(
                thickness: 0.5,
                color: AppColors.stroke,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: TextFormField(
                  onChanged: (value) {
                    setState(() {
                      controller.onChange(description: value);
                    });
                  },
                  initialValue: widget.user.description!,
                  maxLength: 500,
                  maxLines: 8,
                  decoration: InputDecoration(
                    hintStyle: AppTextStyles.inputText,
                    border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                        borderSide: BorderSide(color: AppColors.stroke)),
                    isDense: true,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Center(
                  child: CustomTextButton(
                    onPressed: () async {
                      if (!cities.contains(city)) {
                        final snackBar = SnackBar(
                          content: Text(
                              "O estado: $state não contém a cidade: $city"),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      } else {
                        if (_image != null) {
                          await controller.uploadFile(
                              _image!.path, widget.user.id);
                        }
                        controller.registerUser(context, false);
                        // Navigator.pushNamedAndRemoveUntil(
                        //     context, "/home", ModalRoute.withName('/home'),
                        //     arguments: updatedClient);
                        // Upload da nova imagem no Firebase Storage

                      }
                    },
                    text: "Atualizar",
                    textStyle: AppTextStyles.btnFillText,
                    color: AppColors.primary,
                    isFill: true,
                    width: 200.0,
                    height: 50.0,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
