import 'package:flutter/material.dart';

export 'defaults.dart';

abstract class Validator<T extends Object> {
  String validate(T value);
}

abstract class ValidatorWithStaticError<T extends Object> extends Validator<T> {
  ValidatorWithStaticError(this.error);

  final String error;

  @protected
  String validate(T value) {
    if (innerValidate(value)) {
      return null;
    } else {
      return error;
    }
  }

  bool innerValidate(T value);
}
