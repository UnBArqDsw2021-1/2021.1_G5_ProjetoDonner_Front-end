import 'package:donner/shared/widgets/top_bar_widget/top_bar_option_widget.dart';
import 'package:flutter/material.dart';

import 'package:donner/models/category_model.dart';
import 'package:donner/shared/themes/app_colors.dart';
import 'package:donner/shared/widgets/divider_vertical.dart';

class TopBarWidget extends StatefulWidget {
  CategoryModel? category;
  final VoidCallback? onTapCategory;
  final VoidCallback? onTapFilter;
  TopBarWidget({
    Key? key,
    this.category,
    this.onTapCategory,
    this.onTapFilter,
  }) : super(key: key);

  @override
  State<TopBarWidget> createState() => _TopBarWidgetState();
}

class _TopBarWidgetState extends State<TopBarWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      child: Row(
        children: [
          Expanded(
            child: InkWell(
              splashColor: AppColors.primary.withOpacity(0.2),
              onTap: widget.onTapCategory,
              child: TopBarOptionWidget(
                  text: widget.category != null
                      ? widget.category!.category!
                      : "Categoria"),
            ),
          ),
          DividerVertical(),
          Expanded(
            child: InkWell(
              onTap: widget.onTapFilter,
              child: TopBarOptionWidget(
                text: 'Filtro',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
