import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_auto_form/src/models/form.dart';
import 'package:flutter_auto_form/src/widgets/form_state.dart';

class AFWidget<T extends TemplateForm> extends StatefulWidget {
  const AFWidget({
    Key? key,
    required this.formBuilder,
    required this.onSubmitted,
    this.submitButton,
    this.handleErrorOnSubmit,
    this.enableFinalAction = true,
    this.enableSubmitFormWrapper,
  }) : super(key: key);

  final T Function() formBuilder;

  final Function(T form) onSubmitted;

  final bool enableFinalAction;

  final bool? enableSubmitFormWrapper;

  final ValueChanged<String>? handleErrorOnSubmit;

  final Widget Function(Function() submit)? submitButton;

  @override
  AFWidgetState<T> createState() => AFWidgetState<T>(
        formBuilder(),
        handleErrorOnSubmit: handleErrorOnSubmit,
        enableFinalAction: enableFinalAction,
        enableSubmitFormWrapper: enableSubmitFormWrapper,
      );
}

class AFWidgetState<T extends TemplateForm>
    extends AFFormState<AFWidget<T>, T> {
  AFWidgetState(
    T model, {
    ValueChanged<String>? handleErrorOnSubmit,
    required bool enableFinalAction,
    bool? enableSubmitFormWrapper,
  }) : super(
          model: model,
          handleErrorOnSubmit: handleErrorOnSubmit,
          enableFinalAction: enableFinalAction,
          enableSubmitFormWrapper: enableSubmitFormWrapper,
        );

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
