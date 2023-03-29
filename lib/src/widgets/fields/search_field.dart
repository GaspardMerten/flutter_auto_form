import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auto_form/src/models/field/defaults.dart';
import 'package:flutter_auto_form/src/models/field/field_context.dart';
import 'package:flutter_auto_form/src/widgets/fields/interface.dart';

const _kClearButtonsProps = ClearButtonProps(isVisible: false, iconSize: 0);
const _kPopupsMultiSelectionProp = PopupPropsMultiSelection.menu(
  showSearchBox: true,
  isFilterOnline: true,
);
const _kDropdownButtonProps = DropdownButtonProps(
  isVisible: false,
  iconSize: 0,
);

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

    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: DropdownSearch<T>(
        selectedItem: field.value,
        onChanged: onChanged,
        asyncItems: field.search,
        validator: field.validator,
        autoValidateMode: widget.fieldContext.forceErrorDisplay
            ? AutovalidateMode.always
            : AutovalidateMode.onUserInteraction,
        clearButtonProps: _kClearButtonsProps,
        dropdownButtonProps: _kDropdownButtonProps,
        dropdownBuilder: field.value == null
            ? null
            : (_, __) {
                return SearchModelFieldSelectedItem(
                    name: field.value.toString());
              },
        popupProps: const PopupProps.menu(
          showSearchBox: true,
          isFilterOnline: true,
        ),
        dropdownDecoratorProps: DropDownDecoratorProps(
          dropdownSearchDecoration: InputDecoration(
            errorText: widget.fieldContext.errorText,
            label: Text(widget.fieldContext.field.name),
          ).applyDefaults(decorationTheme),
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

    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: DropdownSearch.multiSelection(
        selectedItems: field.value ?? <T>[],
        onChanged: onChanged,
        dropdownBuilder:
            (field.value?.isEmpty ?? true) ? null : _dropdownBuilder,
        asyncItems: field.search,
        clearButtonProps: _kClearButtonsProps,
        dropdownButtonProps: _kDropdownButtonProps,
        popupProps: _kPopupsMultiSelectionProp,
        dropdownDecoratorProps: DropDownDecoratorProps(
          dropdownSearchDecoration: InputDecoration(
            errorText: widget.fieldContext.errorText,
            label: Text(widget.fieldContext.field.name),
          ).applyDefaults(decorationTheme),
        ),
      ),
    );
  }

  Widget _dropdownBuilder(context, items) => Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          for (final item in items)
            SearchModelFieldSelectedItem(
              name: item.toString(),
            )
        ],
      );
}

class SearchModelFieldSelectedItem extends StatelessWidget {
  const SearchModelFieldSelectedItem({Key? key, required this.name})
      : super(key: key);

  final String name;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 4),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Theme.of(context).colorScheme.surface),
      child: Text(
        name,
        style: const TextStyle(fontSize: 12),
      ),
    );
  }
}
