import 'package:date_field/date_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auto_form/src/models/field/defaults.dart';
import 'package:flutter_auto_form/src/models/field/field_context.dart';
import 'package:flutter_auto_form/src/widgets/fields/interface.dart';

class DateFieldWidget<T extends Object> extends FieldStatefulWidget {
  const DateFieldWidget({
    Key? key,
    required this.fieldContext,
    required this.mode,
  }) : super(key: key);

  @override
  final FieldContext fieldContext;

  final DateTimeFieldPickerMode mode;

  @override
  State<DateFieldWidget<T>> createState() => _DateFieldWidgetState<T>();
}

class _DateFieldWidgetState<T extends Object>
    extends FieldState<DateFieldWidget<T>> {
  late final AFDateField field = widget.fieldContext.field as AFDateField;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: DateTimeFormField(
        mode: widget.mode,
        decoration: InputDecoration(
            labelText: field.name,
            suffixIcon: const Icon(Icons.calendar_month)),
        onChanged: (date) => setState(() {
          widget.fieldContext.onChanged(date);
        }),
        autovalidateMode: widget.fieldContext.forceErrorDisplay
            ? AutovalidateMode.always
            : AutovalidateMode.onUserInteraction,
        validator: field.validator,
        initialPickerDateTime: field.value,
        initialValue: field.value,
      ),
    );
  }
}
