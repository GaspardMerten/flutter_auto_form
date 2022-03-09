import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_auto_form/src/models/field/field.dart';

class FieldContext {
  FieldContext({
    required this.field,
    required this.forceErrorDisplay,
    required this.completeAction,
    required this.isLast,
    this.previousFieldContext,
  });

  final Field field;

  final Function()? completeAction;
  final FieldContext? previousFieldContext;
  late final FieldContext? nextFieldContext;
  final bool isLast;
  final bool forceErrorDisplay;

  final StreamController<void> _focusStreamController = StreamController();

  Stream<void> get focusStream => _focusStreamController.stream;

  void sendRequestFocusEvent() {
    _focusStreamController.add(Object());
  }

  void onChanged(value) {
    field.value = value;
  }
}
