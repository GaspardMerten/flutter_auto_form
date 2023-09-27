import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_auto_form/src/models/form.dart';
import 'package:flutter_auto_form/src/widgets/form_state.dart';

class AFWidget<T extends TemplateForm> extends AFFormStatefulWidget<T> {
  const AFWidget({
    super.key,
    required super.formBuilder,
    required super.onSubmitted,
    super.submitButton,
    super.handleErrorOnSubmit,
    super.enableFinalAction = true,
    super.enableSubmitFormWrapper,
  });

  @override
  AFWidgetState<T> createState() => AFWidgetState<T>();
}

class AFWidgetState<T extends TemplateForm>
    extends AFFormState<AFWidget<T>, T> {
  @override
  Widget build(BuildContext context) {
    Widget child = form();

    if (widget.submitButton != null) {
      child = Column(
        children: [
          child,
          Padding(
            padding: const EdgeInsets.only(top: 16),
            child: widget.submitButton!(
              () => submitForm(),
            ),
          )
        ],
      );
    }

    return child;
  }

  @override
  FutureOr<void> submit(T form) => widget.onSubmitted(form);

  void updateForceError(bool newValue) {
    setState(() {
      forceDisplayFieldsError = newValue;
    });
  }
}
