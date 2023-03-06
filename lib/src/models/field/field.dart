import 'package:flutter_auto_form/src/configuration/typedef.dart';
import 'package:flutter_auto_form/src/models/validators/validator.dart';

export 'defaults.dart';

typedef FieldValueParser<T> = T Function(String value);

/// This class is the base class for any type of custom fields you would
/// want to create. See the [AFTextField] widget to learn more on how
/// to extend it.
abstract class Field<T> {
  Field({required this.id, required this.name, required this.validators});

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

  /// This method returns null if the field is valid. Otherwise it will
  /// return the error's string specified in the validator (see [Validator]).
  String? validator([Object? object]) {
    for (final Validator validator in validators) {
      final String? error = validator.validate(value);

      if (error != null) return error;
    }

    return null;
  }

  /// Parses a value into an instance of T.
  T? parser(covariant Object? unparsedValue);

  FieldWidgetConstructor get widgetBuilder;
}
