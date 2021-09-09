import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

class SearchModelField<T extends Object> extends StatelessWidget {
  const SearchModelField({
    Key? key,
    required this.label,
    required this.search,
    required this.onSelected,
    this.validator,
    required this.selectedValue,
    this.autoValidateMode = AutovalidateMode.onUserInteraction,
  }) : super(key: key);

  final String label;

  final Future<List<T>> Function(String? query) search;

  final Function(T? value) onSelected;

  final FormFieldValidator? validator;

  final T? selectedValue;

  final AutovalidateMode autoValidateMode;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: DropdownSearch<T>(
        label: label,
        onChanged: onSelected,
        selectedItem: selectedValue,
        validator: validator,
        autoValidateMode: autoValidateMode,
        onFind: search,
        mode: Mode.MENU,
        clearButton: const SizedBox(),
        isFilteredOnline: true,
        showClearButton: true,
        showSearchBox: true,
        dropdownSearchDecoration: const InputDecoration().applyDefaults(
          Theme.of(context).inputDecorationTheme,
        ),
      ),
    );
  }
}
