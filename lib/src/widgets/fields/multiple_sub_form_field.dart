import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_auto_form/src/models/field/defaults.dart';
import 'package:flutter_auto_form/src/models/field/field_context.dart';
import 'package:flutter_auto_form/src/models/form.dart';
import 'package:flutter_auto_form/src/widgets/fields/interface.dart';
import 'package:flutter_auto_form/src/widgets/form.dart';

class AFMultipleSubFormFieldWidget<T extends TemplateForm>
    extends FieldStatefulWidget {
  const AFMultipleSubFormFieldWidget({
    Key? key,
    required this.fieldContext,
  }) : super(key: key);

  @override
  final FieldContext fieldContext;

  @override
  State<AFMultipleSubFormFieldWidget<T>> createState() =>
      AFMultipleSubFormFieldWidgetState<T>();
}

class AFMultipleSubFormFieldWidgetState<T extends TemplateForm>
    extends FieldState<AFMultipleSubFormFieldWidget<T>> {
  late final AFMultipleSubFormField<T> field =
      widget.fieldContext.field as AFMultipleSubFormField<T>;

  final Map<int, GlobalKey<AFWidgetState>> formKeys = {};

  late final StreamSubscription subscription;

  GlobalKey<AFWidgetState> _getKey(TemplateForm form) {
    if (!formKeys.containsKey(form.hashCode)) {
      formKeys[form.hashCode] = GlobalKey<AFWidgetState>();
    }

    return formKeys[form.hashCode]!;
  }

  @override
  void initState() {
    super.initState();

    subscription = field.forceErrorStream.listen((_) {
      for (final formKey in formKeys.values) {
        formKey.currentState?.updateForceError(true);
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    subscription.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.only(top: 16),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.black12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            field.name,
          ),
          for (final form in field.forms)
            AFWidget(
              key: _getKey(form),
              formBuilder: () => form,
              onSubmitted: (_) => widget.fieldContext.completeAction,
            ),
        ],
      ),
    );
  }
}
