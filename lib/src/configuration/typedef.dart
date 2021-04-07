import 'package:flutter/material.dart';
import 'package:flutter_auto_form/flutter_auto_form.dart';

typedef TextFieldWidgetBuilder<T> = Widget Function(
  BuildContext context, {
  String? labelText,
  Function(String value)? validator,
  required TextEditingController controller,
  required FocusNode focusNode,
  required bool forceError,
  required TextInputAction action,
  required List<String> autoFillHints,
  required bool obscureText,
  Function()? completeAction,
});

typedef FutureLoadingWidget<T> = Future<T> Function({
  required BuildContext context,
  required Future<T> future,
});

typedef FieldWidgetBuilder<T> = Widget Function(
  BuildContext context, {
  Field? field,
  String? nextFieldId,
  bool? isFinal,
});
