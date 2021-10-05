import 'package:flutter/material.dart';

/// Displays a switch list tile in the form of a field.
class BooleanFieldWidget extends StatelessWidget {
  const BooleanFieldWidget({
    Key? key,
    this.errorText,
    this.value,
    required this.onChanged,
    required this.label,
  }) : super(key: key);

  final String? errorText;
  final bool? value;
  final ValueChanged<bool> onChanged;
  final String label;

  @override
  Widget build(BuildContext context) {
    return InputDecorator(
      decoration: InputDecoration(
        errorText: errorText,
        contentPadding: EdgeInsets.zero,
        border: InputBorder.none,
      ).applyDefaults(
        Theme.of(context).inputDecorationTheme,
      ),
      child: SwitchListTile(
        value: value ?? false,
        contentPadding: EdgeInsets.zero,
        onChanged: onChanged,
        title: Text(
          label,
          style: Theme.of(context).inputDecorationTheme.hintStyle,
        ),
      ),
    );
  }
}
