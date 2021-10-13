import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_auto_form/flutter_auto_form.dart';

/// An interface for the text field builder. See [kTextFieldWidgetBuilder] for
/// an example of a working implementation.
typedef TextFieldWidgetBuilder<T> = Widget Function(
  BuildContext context, {
  String? labelText,
  Function(String? value)? validator,
  required TextEditingController controller,
  required FocusNode focusNode,
  required bool forceError,
  required TextInputAction action,
  required List<String> autoFillHints,
  required bool obscureText,
  Function()? completeAction,
});

/// An interface for the future loader. See [kShowFutureLoadingWidget] for
/// an example of a working implementation.
typedef FutureWrapper<T> = FutureOr<T> Function({
  required BuildContext context,
  required FutureOr<T> future,
});

/// The generic interface for field widget builder.
typedef FieldWidgetBuilder<T> = Widget Function(
  BuildContext context, {
  Field? field,
  String? nextFieldId,
  bool? isFinal,
});
