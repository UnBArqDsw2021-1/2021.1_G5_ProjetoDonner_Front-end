import 'package:flutter/material.dart';

abstract class CustomButton extends StatelessWidget {
  final String text;
  final double height;
  final double width;
  final Color color;
  final TextStyle textStyle;
  final VoidCallback onPressed;
  final bool isFill;

  const CustomButton({
    Key? key,
    required this.text,
    required this.height,
    required this.width,
    required this.color,
    required this.onPressed,
    required this.textStyle,
    required this.isFill,
  }) : super(key: key);

  @override
  Widget build(BuildContext context);
}
