import 'package:donner/widgets/custom_icon_button.dart';
import 'package:donner/widgets/custom_text_button.dart';
import 'package:flutter/material.dart';

class FactoryButton {
  Widget getButton( {required String text, required Color color, required TextStyle textStyle,
      required VoidCallback onPressed, Icon? icon, double height = 50, double width = 200,
      required bool isFill}) {
    if (icon != null) {
      return CustomIconButton(
        icon,
        color: color,
        onPressed: onPressed,
        text: text,
        textStyle: textStyle,
        width: width,
        height: height,
        isFill: isFill,
      );
    }
    return CustomTextButton(
      color: color,
      onPressed: onPressed,
      text: text,
      textStyle: textStyle,
      width: width,
      height: height,
      isFill: isFill,
    );
  }
}
