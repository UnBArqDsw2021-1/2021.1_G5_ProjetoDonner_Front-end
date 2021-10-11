import 'package:donner/shared/themes/app_colors.dart';
import 'package:flutter/material.dart';

class DividerVertical extends StatelessWidget {
  final double thickness;
  const DividerVertical({Key? key, this.thickness = 1}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: thickness,
      height: double.maxFinite,
      color: AppColors.stroke,
    );
  }
}
