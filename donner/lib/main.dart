import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Donner',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Container());
  }
}


//  CustomIconButton(
//               onPressed: () {},
//               color: AppColors.secondary,
//               icon: Icon(
//                 Icons.add,
//                 color: AppColors.backgroundColor,
//               ),
//               text: 'Botão de Ícone',
//               textStyle: AppTextStyles.btnFillText,
//             ),