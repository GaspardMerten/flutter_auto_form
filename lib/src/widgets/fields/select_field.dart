import 'package:flutter/material.dart';
import 'package:flutter_auto_form/flutter_auto_form.dart';
import 'package:flutter_auto_form/src/models/field/field_context.dart';
import 'package:flutter_auto_form/src/widgets/fields/interface.dart';

class SelectFieldWidget<T extends Object> extends FieldStatefulWidget {
  const SelectFieldWidget({
    Key? key,
    required this.fieldContext,
  }) : super(key: key);

  @override
  State<SelectFieldWidget<T>> createState() => _SelectFieldWidgetState<T>();

  @override
  final FieldContext fieldContext;
}

class _SelectFieldWidgetState<T extends Object>
    extends State<SelectFieldWidget<T>> {
  late final AFSelectField<T> field =
      widget.fieldContext.field as AFSelectField<T>;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: DropdownButtonFormField<T>(
        validator: field.validator,
        autovalidateMode: widget.fieldContext.forceErrorDisplay
            ? AutovalidateMode.always
            : AutovalidateMode.onUserInteraction,
        value: field.value,
        onChanged: (e) {
          setState(() {
            widget.fieldContext.onChanged(e);
          });
        },
        items: [
          for (final value in field.values)
            DropdownMenuItem(
              child: Text(field.textBuilder(value)),
              value: value,
            )
        ],
      ),
    );
  }
}
