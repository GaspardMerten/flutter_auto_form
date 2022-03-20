import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_auto_form/src/models/field/field_context.dart';

/// The interface for the [Field.widgetBuilder] method which builds
/// a widget from information available in the [FieldContext] instance it receives.
///
/// Any widget that is supposed to represent a [Field] should interface with
/// this typedef.
typedef FieldWidgetConstructor = Widget Function({
  Key? key,
  required FieldContext fieldContext,
});

/// An interface for the future loader. See [kShowFutureLoadingWidget] for
/// an example of a working implementation.
typedef FutureWrapper<T> = FutureOr<T> Function({
  required BuildContext context,
  required FutureOr<T> future,
});
