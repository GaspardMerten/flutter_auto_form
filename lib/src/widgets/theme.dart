import 'package:flutter/material.dart';
import 'package:flutter_auto_form/flutter_auto_form.dart';
import 'package:flutter_auto_form/src/configuration/defaults.dart';
import 'package:flutter_auto_form/src/configuration/typedef.dart';

const _dTheme = AFThemeData();

class AFTheme extends InheritedWidget {
  const AFTheme({
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
  bool updateShouldNotify(AFTheme oldWidget) {
    return oldWidget.data != data;
  }
}

class AFThemeData {
  const AFThemeData({
    this.submitFormWrapper = kShowFutureLoadingDialog,
    this.enableSubmitFormWrapper = true,
  });

  /// A function that will be called by the [AFFormState] state whenever
  /// the form submitted by the user. It has the responsibility to await
  /// the future received as an argument which is returned by the
  /// [AFFormState.onSubmitted]
  final FutureWrapper submitFormWrapper;

  final bool enableSubmitFormWrapper;
}
