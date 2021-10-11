import 'package:donner/controllers/register_controller.dart';
import 'package:donner/models/client_model.dart';
import 'package:donner/shared/themes/app_colors.dart';
import 'package:donner/shared/themes/app_text_styles.dart';
import 'package:donner/shared/widgets/button_widget/custom_text_button.dart';
import 'package:donner/shared/widgets/input_dropdown_widget.dart';
import 'package:donner/shared/widgets/input_text_widget.dart';
import 'package:estados_municipios/estados_municipios.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class EditProfileScreen extends StatefulWidget {
  final ClientModel user;
  const EditProfileScreen({Key? key, required this.user}) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late RegisterController controller;
  late EstadosMunicipiosController local;
  List<String> states = [];
  List<String> cities = [];
  String? state;
  String? city;

  @override
  void initState() {
    super.initState();
    local = EstadosMunicipiosController();
    controller = RegisterController(FirebaseAuth.instance.currentUser!);
    state = widget.user.state;
    city = widget.user.city;
    listCities(state!);

    listStates();
  }

  void listStates() async {
    var allStates = await local.buscaTodosEstados();

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
                child: Container(
                  width: 150.0,
                  height: 150.0,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      fit: BoxFit.fill,
                      image: NetworkImage(widget.user.photoUrl!),
                    ),
                  ),
                ),
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
                        onChanged: (value) {
                          controller.onChange(phone: value);
                        },
                      ),
                      Row(
                        children: [
                          SizedBox(
                              width: size.width * 0.25,
                              height: 40,
                              child: InputDropdownWidget(
                                onChanged: (value) {
                                  setState(() {
                                    state = value;
                                    controller.onChange(state: value);
                                    listCities(state!);
                                  });
                                },
                                hint: "UF",
                                items: states,
                                enable: true,
                                currentItem: widget.user.state!,
                              )),
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
                            currentItem: widget.user.city!,
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
              Container(
                alignment: Alignment.topLeft,
                height: 150,
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
                child: Text(
                  widget.user.description!,
                  style: AppTextStyles.cardText,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Center(
                  child: CustomTextButton(
                    onPressed: () {
                      if (!cities.contains(city)) {
                        final snackBar = SnackBar(
                          content: Text(
                              "O estado: $state não contém a cidade: $city"),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      } else {
                        controller.updateUser(context);
                      }
                    },
                    text: "Confirmar",
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
