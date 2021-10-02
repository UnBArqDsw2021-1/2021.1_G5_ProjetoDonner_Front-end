import 'package:donner/themes/app_colors.dart';
import 'package:donner/themes/app_text_styles.dart';
import 'package:donner/widgets/button_widget/custom_text_button.dart';
import 'package:donner/widgets/input_dropdown_widget.dart';
import 'package:donner/widgets/input_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:estados_municipios/estados_municipios.dart';
import 'package:dropdown_search/dropdown_search.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  late EstadosMunicipiosController local;
  List<String> states = [];
  List<String> cities = [];
  String? state;
  String? city;
  @override
  void initState() {
    super.initState();
    local = EstadosMunicipiosController();
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
    // cities.sort((a, b) => a.compareTo(b));
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    bool cityIsSelected = false;
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 25),
        child: Column(
          children: [
            Text(
              'Complete seu perfil',
              style: AppTextStyles.pageTitleText,
            ),
            Container(
              padding: const EdgeInsets.only(top: 45, bottom: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  Text(
                    "Telefone:",
                    textAlign: TextAlign.start,
                    style: AppTextStyles.bodyText,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: InputTextWidget(
                      icon: const Icon(
                        Icons.phone,
                        color: AppColors.primary,
                      ),
                      label: "Digite seu número",
                      onChanged: (value) {},
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
                          height: 40,
                          child: DropdownSearch<String>(
                            onChanged: (val) {
                              setState(() {
                                state = val;
                                listCities(state!);
                              });
                            },
                            dropdownSearchDecoration: const InputDecoration(
                              hintText: "UF",
                              contentPadding: EdgeInsets.fromLTRB(12, 12, 0, 0),
                              border: OutlineInputBorder(),
                            ),
                            mode: Mode.DIALOG,
                            showSearchBox: true,
                            popupShape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            popupTitle: Container(
                              alignment: Alignment.center,
                              decoration: const BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(10),
                                      topRight: Radius.circular(10)),
                                  color: AppColors.secondary),
                              height: 40,
                              child: const Text("Unidades Federativas",
                                  style: TextStyle(
                                      color: AppColors.backgroundColor)),
                            ),
                            items: states,
                          ),
                        ),
                        Expanded(
                          child: Container(
                            height: 40,
                            padding: const EdgeInsets.only(left: 10),
                            child: DropdownSearch<String>(
                              onChanged: (val){
                                setState(() {
                                  city = val;
                                });
                              },
                              enabled: state != null ? true : false,
                              dropdownSearchDecoration: const InputDecoration(
                                hintText: "Cidade",
                                contentPadding:
                                    EdgeInsets.fromLTRB(12, 12, 0, 0),
                                border: OutlineInputBorder(),
                              ),
                              mode: Mode.DIALOG,
                              showSearchBox: true,
                              popupShape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              popupTitle: Container(
                                alignment: Alignment.center,
                                decoration: const BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(10),
                                        topRight: Radius.circular(10)),
                                    color: AppColors.secondary),
                                height: 40,
                                child: const Text("Cidades",
                                    style: TextStyle(
                                        color: AppColors.backgroundColor)),
                              ),
                              items: state != null ? cities : [],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text("Adicione uma descrição (opcional):",
                      style: AppTextStyles.bodyText),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: TextField(
                      maxLength: 500,
                      maxLines: 12,
                      decoration: InputDecoration(
                        hintText:
                            "Digite um descrição sobre você ou sua empresa de até 500 caracteres",
                        hintStyle: AppTextStyles.inputText,
                        border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            borderSide: BorderSide(color: AppColors.stroke)),
                        isDense: true,
                        // contentPadding: EdgeInsets.symmetric(vertical: 150),
                      ),
                    ),
                  ),
                  Center(
                    child: CustomTextButton(
                      onPressed: () {
                        print("Estado: $state, Cidade: $city");
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
          ],
        ),
      ),
    );
  }
}
