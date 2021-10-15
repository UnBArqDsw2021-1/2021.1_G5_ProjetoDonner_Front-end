import 'package:donner/shared/themes/app_colors.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

class InputDropdownWidget extends StatefulWidget {
  final String? state;
  final bool enable;
  final void Function(String? value) onChanged;
  final List<String> items;
  final String hint;
  final String? Function(String?)? validator;
  final String? currentItem;

  InputDropdownWidget({
    Key? key,
    required this.onChanged,
    required this.hint,
    required this.items,
    this.state,
    required this.enable,
    this.validator,
    this.currentItem,
  }) : super(key: key);
  @override
  _InputDropdownWidgetState createState() => _InputDropdownWidgetState();
}

class _InputDropdownWidgetState extends State<InputDropdownWidget> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: DropdownSearch<String>(
        validator: widget.validator,
        onChanged: widget.onChanged,
        enabled: widget.enable,
        showAsSuffixIcons: true,
        dropdownSearchDecoration: InputDecoration(
          hintText: widget.hint,
          contentPadding: const EdgeInsets.fromLTRB(12, 12, 0, 0),
          border: const OutlineInputBorder(),
        ),
        mode: Mode.DIALOG,
        showSearchBox: (widget.items.length > 5),
        popupShape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        popupTitle: Container(
          alignment: Alignment.center,
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10), topRight: Radius.circular(10)),
              color: AppColors.secondary),
          height: 40,
          child: Text(widget.hint,
              style: const TextStyle(color: AppColors.backgroundColor)),
        ),
        items: widget.items,
        selectedItem: widget.currentItem,
      ),
    );
  }
}
