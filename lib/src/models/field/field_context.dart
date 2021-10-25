import 'package:flutter/cupertino.dart';

@immutable
class FieldContext<T extends Object> {
  const FieldContext({
    required this.forceErrorDisplay,
    required this.completeAction,
    required this.onChanged,
    required this.isLast,
  });

  final Function() completeAction;
  final Function(T value) onChanged;
  final bool isLast;
  final bool forceErrorDisplay;
}
