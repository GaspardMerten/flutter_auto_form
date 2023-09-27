import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_auto_form/src/widgets/utils/loading_widget.dart';

/// The default loading dialog builder used by the [AFTheme] widget.
/// See [FutureLoadingWidget] if you want to create your own loading dialog
/// compatible with the requirement of the [AFTheme].
Future<T> kShowFutureLoadingDialog<T>({
  required BuildContext context,
  required FutureOr<T> future,
}) async {
  final T response = await showDialog<dynamic>(
    context: context,
    barrierDismissible: true,
    builder: (BuildContext context) => DefaultLoadingWidget(
      popOnComplete: true,
      future: future,
    ),
  );

  return response;
}
