import 'package:flutter/material.dart';
import 'package:flutter_auto_form/flutter_auto_form.dart';
import 'package:flutter_auto_form/src/configuration/defaults.dart';
import 'package:flutter_auto_form/src/configuration/typedef.dart';

const _dTheme = AFThemeData();

class AFTheme extends InheritedWidget {
  AFTheme({
    Key? key,
    required Widget child,
    this.data = _dTheme,
  }) : super(key: key, child: child);

  final AFThemeData data;

  static AFThemeData of(BuildContext context) {
    final result = context.dependOnInheritedWidgetOfExactType<AFTheme>()?.data;

    return result ?? _dTheme;
  }

  @override
  bool updateShouldNotify(AFTheme old) {
    return old.data != data;
  }
}

class AFThemeData {
  const AFThemeData({
    this.textFieldWidgetBuilder = kTextFieldWidgetBuilder,
    this.showFutureLoadingWidget = kShowFutureLoadingWidget,
  });

  final TextFieldWidgetBuilder textFieldWidgetBuilder;
  final FutureLoadingWidget showFutureLoadingWidget;

  Widget buildField(String? nextFocusName, Field<Object> field, bool isFinal) {
    throw UnimplementedError(
        'Override the buildField method to render custom Field !');
  }
}
