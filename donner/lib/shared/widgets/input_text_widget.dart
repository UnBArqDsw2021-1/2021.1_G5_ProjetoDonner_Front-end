import 'package:donner/shared/themes/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class InputTextWidget extends StatelessWidget {
  final String? label;
  final String? initialValue;
  final Icon? icon;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final List<TextInputFormatter>? formatter;
  final void Function(String value) onChanged;
  const InputTextWidget({
    Key? key,
    this.label,
    this.initialValue,
    this.icon,
    this.validator,
    this.formatter,
    required this.onChanged,
    this.keyboardType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: keyboardType,
      onChanged: onChanged,
      inputFormatters: formatter,
      validator: validator,
      initialValue: initialValue,
      decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(vertical: 10),
          prefixIcon: Container(
            margin: const EdgeInsets.only(right: 5),
            decoration: const BoxDecoration(
                border: Border(
              right: BorderSide(color: AppColors.stroke),
            )),
            child: icon,
          ),
          enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.stroke)),
          focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.primary)),
          labelText: label,
          labelStyle: const TextStyle(color: AppColors.inputTextColor)),
    );
  }
}
