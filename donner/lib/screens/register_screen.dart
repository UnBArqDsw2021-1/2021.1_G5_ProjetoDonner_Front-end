import 'package:donner/controllers/profile_controller.dart';
import 'package:donner/shared/themes/app_colors.dart';
import 'package:donner/shared/themes/app_text_styles.dart';
import 'package:donner/shared/widgets/button_widget/custom_text_button.dart';
import 'package:donner/shared/widgets/input_dropdown_widget.dart';
import 'package:donner/shared/widgets/input_text_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:estados_municipios/estados_municipios.dart';

class RegisterScreen extends StatefulWidget {
  final User user;
  const RegisterScreen({Key? key, required this.user}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  late ProfileController controller;
  late EstadosMunicipiosController local;
  List<String> states = [];
  List<String> cities = [];
  String? state;
  String? city;

  @override
  void initState() {
    super.initState();
    local = EstadosMunicipiosController();
    controller = ProfileController(widget.user);
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
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 25),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                'Complete seu perfil',
                style: AppTextStyles.pageTitleText,
              ),
              Container(
                padding: const EdgeInsets.only(top: 45, bottom: 15),
                child: Form(
                  key: controller.formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Telefone:",
                        textAlign: TextAlign.start,
                        style: AppTextStyles.bodyText,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: InputTextWidget(
                          keyboardType: TextInputType.phone,
                          validator: controller.validatePhone,
                          formatter: [controller.maskFormatter],
                          icon: const Icon(
                            Icons.phone,
                            color: AppColors.primary,
                          ),
                          label: "Digite seu número",
                          onChanged: (value) {
                            controller.onChange(phone: value);
                          },
                        ),
                      ),
                      Text(
                        "Local:",
                        textAlign: TextAlign.start,
                        style: AppTextStyles.bodyText,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Row(
                          children: [
                            SizedBox(
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
                              currentItem: city,
                            )),
                          ],
                        ),
                      ),
                      Text("Adicione uma descrição (opcional):",
                          style: AppTextStyles.bodyText),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: TextField(
                          onChanged: (value) {
                            setState(() {
                              controller.onChange(description: value);
                            });
                          },
                          maxLength: 500,
                          maxLines: 12,
                          decoration: InputDecoration(
                            hintText:
                                "Digite um descrição sobre você ou sua empresa de até 500 caracteres",
                            hintStyle: AppTextStyles.inputText,
                            border: const OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5)),
                                borderSide:
                                    BorderSide(color: AppColors.stroke)),
                            isDense: true,
                          ),
                        ),
                      ),
                      Center(
                        child: CustomTextButton(
                          onPressed: () {
                            if (!cities.contains(city)) {
                              final snackBar = SnackBar(
                                content: Text(
                                    "O estado: $state não contém a cidade: $city"),
                              );
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                            } else {
                              controller.registerUser(context, true);
                            }
                          },
                          text: "Confirmar",
                          textStyle: AppTextStyles.btnFillText,
                          color: AppColors.primary,
                          isFill: true,
                          width: 200.0,
                          height: 50.0,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
