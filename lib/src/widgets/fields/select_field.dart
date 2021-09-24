import 'package:flutter/material.dart';

class SelectField<T> extends StatelessWidget {
  const SelectField({
    Key? key,
    required this.value,
    required this.textBuilder,
    required this.values,
    required this.onChanged,
  }) : super(key: key);

  final T value;
  final List<T> values;
  final ValueChanged<T?> onChanged;
  final String Function(T value) textBuilder;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<T>(
      value: value,
      onChanged: onChanged,
      items: [
        for (final value in values)
          DropdownMenuItem(
            child: Text(textBuilder(value)),
            value: value,
          )
      ],
    );
  }
}
