export 'defaults.dart';

/// The [Validator] class is used by the [Field] class to validate its input.
abstract class Validator<T extends Object?> {
  /// This method should return null if the field is valid, a string corresponding
  /// to the error otherwise.
  String? validate(T value);
}

/// As its name suggests, this class makes it easier to create a validator
/// which returns a static error message (that does not change based on the data).
abstract class ValidatorWithStaticError<T extends Object?>
    extends Validator<T> {
  ValidatorWithStaticError(this.error);

  final String error;

  @override
  String? validate(T? value) {
    if (innerValidate(value)) {
      return null;
    } else {
      return error;
    }
  }

  /// Returns true or false depending on the validation process. This method
  /// is then used by the [ValidatorWithStaticError.validate] method to return
  /// a static error if the result is false.
  bool innerValidate(T? value);
}
