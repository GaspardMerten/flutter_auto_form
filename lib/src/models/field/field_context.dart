import 'dart:async';

import 'package:flutter_auto_form/src/models/field/field.dart';

class FieldContext {
  FieldContext({
    required this.field,
    required this.forceErrorDisplay,
    required this.completeAction,
    this.previous,
  });

  final Field field;

  final Function()? completeAction;

  final FieldContext? previous;

  late final FieldContext? next;

  bool forceErrorDisplay;

  final StreamController<void> _focusStreamController = StreamController();

  Stream<void> get focusStream => _focusStreamController.stream;

  bool get isLast => next == null;

  void sendRequestFocusEvent() {
    _focusStreamController.add(Object());
  }

  void onChanged(value) {
    field.value = value;
  }

  void updateWith({bool? forceErrorDisplay}) {
    this.forceErrorDisplay = forceErrorDisplay ?? this.forceErrorDisplay;
  }
}
