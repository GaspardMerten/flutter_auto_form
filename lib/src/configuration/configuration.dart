import 'package:flutter/material.dart';
import 'package:flutter_auto_form/src/configuration/typedef.dart';
import 'package:flutter_auto_form/src/models/field/field.dart';

import 'defaults.dart';

class AutoFormConfiguration {
  AutoFormConfiguration._({
    @required this.textFieldWidgetBuilder,
    @required this.showFutureLoadingWidget,
  });

  factory AutoFormConfiguration() => _instance;

  factory AutoFormConfiguration.setDefaults({
    TextFieldWidgetBuilder textFieldWidgetBuilder,
  }) {
    if (textFieldWidgetBuilder != null) {
      _instance.textFieldWidgetBuilder = textFieldWidgetBuilder;
    }

    return _instance;
  }

  @protected
  static AutoFormConfiguration _instance = AutoFormConfiguration._(
    textFieldWidgetBuilder: kTextFieldWidgetBuilder,
    showFutureLoadingWidget: kShowFutureLoadingWidget,
  );

  TextFieldWidgetBuilder textFieldWidgetBuilder;

  FutureLoadingWidget showFutureLoadingWidget;

  Widget buildField(String nextFocusName, Field<Object> field, bool isFinal) {
    throw UnimplementedError(
        'Override the buildField method to render custom Field !');
  }
}
