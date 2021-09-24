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
  }) : super(key: key);

  final T Function() formBuilder;

  final Function(T form) onSubmitted;

  final bool enableFinalAction;

  final ValueChanged<String>? handleErrorOnSubmit;

  final Widget Function(Function({bool showLoadingDialog}) submit)?
      submitButton;

  @override
  AFWidgetState<T> createState() => AFWidgetState<T>(
        formBuilder(),
        handleErrorOnSubmit: handleErrorOnSubmit,
        enableFinalAction: enableFinalAction,
      );
}

class AFWidgetState<T extends TemplateForm>
    extends AFFormState<AFWidget<T>, T> {
  AFWidgetState(T model,
      {ValueChanged<String>? handleErrorOnSubmit,
      required bool enableFinalAction})
      : super(
          model: model,
          handleErrorOnSubmit: handleErrorOnSubmit,
          enableFinalAction: enableFinalAction,
        );

  @override
  Widget build(BuildContext context) {
    widget;
    Widget child = form();

    if (widget.submitButton != null) {
      child = Column(
        children: [
          child,
          Padding(
            padding: const EdgeInsets.only(top: 16),
            child: widget.submitButton!(
              ({bool showLoadingDialog = false}) => submitForm(
                showLoading: showLoadingDialog,
              ),
            ),
          )
        ],
      );
    }

    return child;
  }

  @override
  FutureOr<void> submit(T form) => widget.onSubmitted(form);
}
