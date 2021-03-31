import 'package:flutter/material.dart';
import 'package:flutter_auto_form/flutter_auto_form.dart';

typedef TextFieldWidgetBuilder<T> = Widget Function(
  BuildContext context, {
  String labelText,
  Function(T value) validator,
  TextEditingController controller,
  FocusNode focusNode,
  TextInputAction action,
  bool forceError,
  Function() completeAction,
  List<String> autoFillHints,
  bool obscureText,
});

typedef FutureLoadingWidget<T> = Future<T> Function({
  @required BuildContext context,
  @required Future<T> future,
});

typedef FieldWidgetBuilder<T> = Widget Function(
  BuildContext context, {
  Field field,
  String nextFieldId,
  bool isFinal,
});
