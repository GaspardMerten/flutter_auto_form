import 'package:flutter_auto_form/src/models/validator/validator.dart';

export 'defaults.dart';

typedef FieldValueParser<T> = T Function(String value);

/// This class is the base class for any type of custom fields you would
/// want to create. See the [AFTextField] widget to learn more on how
/// to extend it.
abstract class Field<T extends Object> {
  Field(this.id, this.name, this.validators);

  /// A unique identifier for the field which will be used to retrieve its data.
  final String id;

  /// The name that will be displayed to the user.
  final String name;

  /// A list of validators that will be used to verify the user's input.
  final List<Validator> validators;

  /// The current value of the field.
  T? _value;

  /// The current value of the field.
  T? get value => _value;

  /// The current value of the field.
  set value(covariant Object? value) {
    _value = parser(value);
  }

  /// This method returns null if the field is valid. Otherwhise it will
  /// return the error's string specified in the validator (see [Validator]).
  String? validate(T? value) {
    for (final Validator validator in validators) {
      final String? error = validator.validate(value);

      if (error != null) return error;
    }

    return null;
  }

  T? parser(covariant Object? unparsedValue);
}
