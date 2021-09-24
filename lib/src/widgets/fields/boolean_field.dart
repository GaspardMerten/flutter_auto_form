import 'package:flutter/material.dart';

class BooleanField extends StatelessWidget {
  const BooleanField({
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
              border: InputBorder.none)
          .applyDefaults(
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
