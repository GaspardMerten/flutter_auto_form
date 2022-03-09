import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auto_form/flutter_auto_form.dart';
import 'package:flutter_auto_form/src/models/field/field_context.dart';
import 'package:flutter_auto_form/src/widgets/fields/interface.dart';

class SearchModelFieldWidget<T extends Object> extends FieldStatefulWidget {
  const SearchModelFieldWidget({
    Key? key,
    required this.fieldContext,
  }) : super(key: key);

  @override
  final FieldContext fieldContext;

  @override
  State<SearchModelFieldWidget<T>> createState() =>
      _SearchModelFieldWidgetState<T>();
}

class _SearchModelFieldWidgetState<T extends Object>
    extends FieldState<SearchModelFieldWidget<T>> {
  late final AFSearchModelField<T> field =
      widget.fieldContext.field as AFSearchModelField<T>;

  @override
  Widget build(BuildContext context) {
    final decorationTheme = Theme.of(context).inputDecorationTheme;

    return DropdownSearch<T>(
      selectedItem: field.value,
      onChanged: onChanged,
      validator: field.validator,
      autoValidateMode: widget.fieldContext.forceErrorDisplay
          ? AutovalidateMode.always
          : AutovalidateMode.onUserInteraction,
      onFind: field.search,
      mode: Mode.MENU,
      clearButton: const SizedBox(),
      isFilteredOnline: true,
      showClearButton: true,
      showSearchBox: true,
      dropdownSearchDecoration: InputDecoration(
        label: Text(widget.fieldContext.field.name),
      ).applyDefaults(decorationTheme),
    );
  }
}

class SearchMultipleModelsField<T extends Object> extends FieldStatefulWidget {
  const SearchMultipleModelsField({
    Key? key,
    required this.fieldContext,
  }) : super(key: key);

  @override
  final FieldContext fieldContext;

  @override
  State<SearchMultipleModelsField<T>> createState() =>
      _SearchMultipleModelsFieldState<T>();
}

class _SearchMultipleModelsFieldState<T extends Object>
    extends FieldState<SearchMultipleModelsField<T>> {
  late final AFSearchMultipleModelsField<T> field =
      widget.fieldContext.field as AFSearchMultipleModelsField<T>;

  @override
  Widget build(BuildContext context) {
    final decorationTheme = Theme.of(context).inputDecorationTheme;

    return DropdownSearch.multiSelection(
      selectedItems: field.value ?? <T>[],
      onChanged: onChanged,
      validator: widget.fieldContext.forceErrorDisplay ? field.validator : null,
      onFind: field.search,
      mode: Mode.MENU,
      clearButton: const SizedBox(),
      isFilteredOnline: true,
      showClearButton: true,
      showSearchBox: true,
      dropdownSearchDecoration: InputDecoration(
        label: Text(widget.fieldContext.field.name),
      ).applyDefaults(decorationTheme),
    );
  }
}
