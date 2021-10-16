import 'package:donner/shared/widgets/button_widget/factory_button.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:donner/models/category_model.dart';
import 'package:donner/shared/themes/app_colors.dart';
import 'package:donner/shared/themes/app_text_styles.dart';

class FilterScreen extends StatefulWidget {
  CategoryModel? category;
  FilterScreen({Key? key, this.category}) : super(key: key);

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  final btn = FactoryButton();
  Map filters = {};
  bool isDonationSelected = false;
  bool isOrderSelected = false;
  bool isDataSelected = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Filtro",
          style: AppTextStyles.appBarText,
        ),
        centerTitle: true,
        backgroundColor: AppColors.primary,
        leading: GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: const Icon(
              FontAwesomeIcons.chevronLeft,
              color: AppColors.backgroundColor,
              size: 30,
            )),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Selecione a categoria", style: AppTextStyles.bodyText),
            Container(
              margin: const EdgeInsets.only(top: 10, bottom: 20),
              height: 40,
              decoration: BoxDecoration(
                border: Border.all(width: 0.5),
                borderRadius: BorderRadius.circular(5),
              ),
              child: TextButton(
                onPressed: () async {
                  final result = await Navigator.pushNamed(context, '/category')
                      as CategoryModel?;
                  setState(() {
                    if (result != null) {
                      widget.category = result;
                    }
                  });
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    widget.category == null
                        ? Text("Categoria", style: AppTextStyles.inputText)
                        : Text(
                            widget.category!.category!,
                            style: AppTextStyles.bodyText,
                          ),
                    const Icon(
                      Icons.expand_more_outlined,
                      color: AppColors.primary,
                    )
                  ],
                ),
              ),
            ),
            Text("Tipo de anúncio", style: AppTextStyles.bodyText),
            Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 20),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    btn.getButton(
                        onPressed: () {
                          setState(() {
                            isDonationSelected = !isDonationSelected;
                            isOrderSelected = false;
                          });
                        },
                        text: "Doações",
                        textStyle: isDonationSelected
                            ? AppTextStyles.btnFillText
                            : AppTextStyles.primaryBtnOutlinedText,
                        color: AppColors.primary,
                        height: 40,
                        width: 117,
                        isFill: isDonationSelected),
                    btn.getButton(
                      onPressed: () {
                        setState(() {
                          isOrderSelected = !isOrderSelected;
                          isDonationSelected = false;
                        });
                      },
                      text: "Pedidos",
                      textStyle: isOrderSelected
                          ? AppTextStyles.btnFillText
                          : AppTextStyles.primaryBtnOutlinedText,
                      color: AppColors.primary,
                      height: 40,
                      width: 117,
                      isFill: isOrderSelected,
                    )
                  ]),
            ),
            Text("Ordenar por", style: AppTextStyles.bodyText),
            Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 40, left: 40),
              child: btn.getButton(
                onPressed: () {
                  setState(() {
                    isDataSelected = !isDataSelected;
                  });
                },
                text: "Data",
                textStyle: isDataSelected
                    ? AppTextStyles.btnFillText
                    : AppTextStyles.primaryBtnOutlinedText,
                color: AppColors.primary,
                height: 40,
                width: 117,
                isFill: isDataSelected,
                icon: Icon(
                  FontAwesomeIcons.calendar,
                  color: isDataSelected
                      ? AppColors.backgroundColor
                      : AppColors.primary,
                ),
              ),
            ),
            Center(
              child: btn.getButton(
                onPressed: () {
                  var filters = {
                    'category': widget.category,
                    'isDonation': !isDonationSelected && !isOrderSelected
                        ? null
                        : isDonationSelected,
                    'date': !isDataSelected ? null : isDataSelected,
                  };

                  Navigator.pop(context, filters);
                },
                text: "Filtrar",
                textStyle: AppTextStyles.btnFillText,
                color: AppColors.primary,
                height: 40,
                width: 200,
                isFill: true,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
