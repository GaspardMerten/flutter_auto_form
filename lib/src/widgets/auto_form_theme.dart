import 'package:flutter/material.dart';
import 'package:flutter_auto_form/flutter_auto_form.dart';
import 'package:flutter_auto_form/src/configuration/defaults.dart';
import 'package:flutter_auto_form/src/configuration/typedef.dart';

class AutoFormTheme extends InheritedWidget {
  AutoFormTheme({
    Key key,
    @required Widget child,
    this.textFieldWidgetBuilder = kTextFieldWidgetBuilder,
    this.showFutureLoadingWidget = kShowFutureLoadingWidget,
  }) : super(key: key, child: child);

  static AutoFormTheme of(BuildContext context) {
    final AutoFormTheme result =
        context.dependOnInheritedWidgetOfExactType<AutoFormTheme>();

    assert(result != null,
        'Please wrap the current widget with an AutoFormTheme widget.');

    return result;
  }

  final TextFieldWidgetBuilder textFieldWidgetBuilder;
  final FutureLoadingWidget showFutureLoadingWidget;

  Widget buildField(String nextFocusName, Field<Object> field, bool isFinal) {
    throw UnimplementedError(
        'Override the buildField method to render custom Field !');
  }

  @override
  bool updateShouldNotify(AutoFormTheme old) {
    return textFieldWidgetBuilder != old.textFieldWidgetBuilder ||
        showFutureLoadingWidget != old.showFutureLoadingWidget;
  }
}
