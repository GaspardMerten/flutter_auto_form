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
  State<SearchModelFieldWidget> createState() =>
      _SearchModelFieldWidgetState<T>();
}

class _SearchModelFieldWidgetState<T extends Object>
    extends State<SearchModelFieldWidget<T>> {
  late final AFSearchModelField<T> field =
      widget.fieldContext.field as AFSearchModelField<T>;

  @override
  Widget build(BuildContext context) {
    final defaultDecoration = Theme.of(context).inputDecorationTheme;

    return SizedBox(
      height: 80,
      child: DropdownSearch<T>(
        onChanged: (newValue) => setState(() {
          widget.fieldContext.onChanged(newValue);
        }),
        selectedItem: field.value,
        validator: field.validate,
        onFind: field.search,
        mode: Mode.MENU,
        clearButton: const SizedBox(),
        isFilteredOnline: true,
        showClearButton: true,
        showSearchBox: true,
        dropdownSearchDecoration:
            InputDecoration(label: Text(field.name)).applyDefaults(
          defaultDecoration,
        ),
      ),
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
  State<SearchMultipleModelsField> createState() =>
      _SearchMultipleModelsFieldState<T>();
}

class _SearchMultipleModelsFieldState<T extends Object>
    extends State<SearchMultipleModelsField<T>> {
  late final AFSearchMultipleModelsField<T> field =
      widget.fieldContext.field as AFSearchMultipleModelsField<T>;

  @override
  Widget build(BuildContext context) {
    return DropdownSearch.multiSelection(
      onFind: field.search,
      selectedItems: field.value ?? <T>[],
      mode: Mode.MENU,
      onChanged: (newValue) => setState(() {
        field.value = newValue;
      }),
      dropdownBuilder: (context, List<T>? values) {
        return Text(values?.join(',') ?? '');
      },
      clearButton: const SizedBox(),
      isFilteredOnline: true,
      showClearButton: true,
      showSearchBox: true,
      dropdownSearchDecoration: InputDecoration(
        label: Text(field.name),
      ).applyDefaults(
        Theme.of(context).inputDecorationTheme,
      ),
    );
  }
}
