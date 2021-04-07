import 'package:flutter_auto_form/src/models/validator/validator.dart';

export 'defaults.dart';

typedef FieldValueParser<T> = T Function(String value);

abstract class Field<T extends Object> {
  Field(this.id, this.name, this.validators);

  final String id;
  final String name;
  final List<Validator> validators;

  T? value;

  String? validate(dynamic value) {
    for (final Validator validator in validators) {
      final String? error = validator.validate(value);

      if (error != null) return error;
    }

    return null;
  }
}
