import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_auto_form/src/models/form.dart';
import 'package:flutter_auto_form/src/widgets/form_state.dart';

class AutoFormWidget<T extends TemplateForm> extends StatefulWidget {
  const AutoFormWidget(
      {Key key,
      @required this.formBuilder,
      @required this.onSubmitted,
      this.submitButton})
      : super(key: key);

  final T Function() formBuilder;

  final Function(T form) onSubmitted;

  final Widget Function(Function(bool showLoadingDialog) submit) submitButton;

  @override
  _AutoFormWidgetState createState() => _AutoFormWidgetState<T>(formBuilder());
}

class _AutoFormWidgetState<T extends TemplateForm>
    extends GAFormState<AutoFormWidget, T> {
  _AutoFormWidgetState(T model) : super(model);

  @override
  Widget build(BuildContext context) {
    Widget child = form();

    if (widget.submitButton != null) {
      child = Column(
        children: [
          child,
          widget.submitButton(
            (bool showLoadingDialog) =>
                submitForm(showLoading: showLoadingDialog),
          )
        ],
      );
    }

    return child;
  }

  @override
  FutureOr<void> submit(T form) async {
    await Future<void>.delayed(Duration(seconds: 1));

    widget.onSubmitted(form);
  }
}
