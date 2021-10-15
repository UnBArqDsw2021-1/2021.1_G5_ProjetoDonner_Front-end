import 'package:donner/shared/themes/app_colors.dart';
import 'package:donner/shared/themes/app_text_styles.dart';
import 'package:donner/shared/widgets/button_widget/custom_text_button.dart';
import 'package:flutter/material.dart';

class ModalBottomWidget extends StatelessWidget {
  final String title;
  final VoidCallback? onPressedConfirmBtn;
  const ModalBottomWidget(
      {Key? key, required this.title, this.onPressedConfirmBtn})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
            child: Text.rich(
              TextSpan(
                  text: "Você tem certeza que deseja excluir o anúncio de ",
                  style: AppTextStyles.modalBottomText,
                  children: [
                    TextSpan(
                        text: '\n${title}',
                        style: AppTextStyles.modalBottomTextBold)
                  ]),
              textAlign: TextAlign.center,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CustomTextButton(
                text: "Encerrar",
                color: AppColors.secondary,
                textStyle: AppTextStyles.btnFillText,
                height: 50.0,
                width: 150.0,
                isFill: true,
                onPressed: onPressedConfirmBtn,
              ),
              CustomTextButton(
                text: "Cancelar",
                onPressed: () {
                  Navigator.of(context).pop();
                },
                color: AppColors.secondary,
                textStyle: AppTextStyles.secondaryBtnOutlinedText,
                height: 50.0,
                width: 150.0,
                isFill: false,
              )
            ],
          )
        ],
      ),
    );
  }
}

class ModalBottomWidgetText {}
