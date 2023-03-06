import 'package:flutter/material.dart';
import 'package:flutter_auto_form/flutter_auto_form.dart';

class BooleanFieldWidget extends FieldStatefulWidget {
  const BooleanFieldWidget({
    Key? key,
    required this.fieldContext,
  }) : super(key: key);

  @override
  final FieldContext fieldContext;

  @override
  State<BooleanFieldWidget> createState() => _BooleanFieldWidgetState();
}

/// Displays a switch list tile in the form of a field.
class _BooleanFieldWidgetState extends State<BooleanFieldWidget> {
  late final AFBooleanField field = widget.fieldContext.field as AFBooleanField;

  @override
  Widget build(BuildContext context) {
    return InputDecorator(
      decoration: InputDecoration(
        errorText: widget.fieldContext.forceErrorDisplay
            ? field.validator(field.value)
            : null,
        contentPadding: EdgeInsets.zero,
        border: InputBorder.none,
      ).applyDefaults(
        Theme.of(context).inputDecorationTheme,
      ),
      child: SwitchListTile(
        value: field.value ?? false,
        contentPadding: EdgeInsets.zero,
        onChanged: (newValue) => setState(() {
          widget.fieldContext.onChanged(newValue);
        }),
        title: Text(
          field.name,
          style: Theme.of(context).inputDecorationTheme.hintStyle,
        ),
      ),
    );
  }
}
