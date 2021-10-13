import 'package:donner/shared/themes/app_colors.dart';
import 'package:flutter/material.dart';

class InputTextWidget extends StatelessWidget {
  final String? label;
  final Icon? icon;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final void Function(String value) onChanged;
  const InputTextWidget(
      {Key? key,
      this.label,
      this.icon,
      this.validator,
      this.controller,
      required this.onChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: onChanged,
      controller: controller,
      validator: validator,
      decoration: InputDecoration(
          contentPadding: icon != null
              ? const EdgeInsets.symmetric(vertical: 10)
              : EdgeInsets.symmetric(horizontal: 10),
          prefixIcon: icon != null
              ? Container(
                  margin: const EdgeInsets.only(right: 5),
                  decoration: const BoxDecoration(
                      border: Border(
                    right: BorderSide(color: AppColors.stroke),
                  )),
                  child: icon,
                )
              : null,
          enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.stroke)),
          focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.primary)),
          labelText: label,
          labelStyle: const TextStyle(color: AppColors.inputTextColor)),
    );
  }
}
