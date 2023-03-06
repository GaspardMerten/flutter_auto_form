import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_auto_form/src/models/field/defaults.dart';
import 'package:flutter_auto_form/src/models/field/field_context.dart';
import 'package:flutter_auto_form/src/models/form.dart';
import 'package:flutter_auto_form/src/widgets/fields/interface.dart';
import 'package:flutter_auto_form/src/widgets/form.dart';

class AFSubFormFieldWidget<T extends TemplateForm> extends FieldStatefulWidget {
  const AFSubFormFieldWidget({
    Key? key,
    required this.fieldContext,
  }) : super(key: key);

  @override
  final FieldContext fieldContext;

  @override
  State<AFSubFormFieldWidget<T>> createState() =>
      AFSubFormFieldWidgetState<T>();
}

class AFSubFormFieldWidgetState<T extends TemplateForm>
    extends FieldState<AFSubFormFieldWidget<T>> {
  late final AFSubFormField<T> field =
      widget.fieldContext.field as AFSubFormField<T>;

  final formKey = GlobalKey<AFWidgetState>();

  late final StreamSubscription subscription;

  @override
  void initState() {
    super.initState();

    subscription = field.forceErrorStream.listen((event) {
      formKey.currentState?.updateForceError(true);
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
      decoration: BoxDecoration(
          border: Border.all(color: Colors.black12),
          borderRadius: BorderRadius.circular(16)),
      margin: const EdgeInsets.only(top: 16),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            field.name,
          ),
          AFWidget(
            key: formKey,
            formBuilder: () => field.form,
            onSubmitted: (_) => widget.fieldContext.completeAction,
          ),
        ],
      ),
    );
  }
}
