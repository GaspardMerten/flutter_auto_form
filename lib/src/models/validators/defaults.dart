import 'package:flutter_auto_form/flutter_auto_form.dart';
import 'package:flutter_auto_form/src/models/validators/regex.dart';

class FuncValidator<T> extends ValidatorWithStaticError<T> {
  FuncValidator({required String error, required this.isValid}) : super(error);

  final bool Function(T? value) isValid;

  @override
  bool innerValidate(T? value) {
    return isValid(value);
  }
}

/// Checks whether a given url string is valid. Null is deemed as an acceptable
/// url.
class URLValidator extends ValidatorWithStaticError<String> {
  const URLValidator(String error) : super(error);

  @override
  bool innerValidate(String? value) {
    return value == null || RegExp(urlRegex).hasMatch(value);
  }
}

/// An enum used by the [HexColorValidator] to specify which format of hex color
/// is accepted.
///
/// Both: #ff2f2f and ff2f2f are accepted
/// withHashtag: only #ff2f2f is accepted
/// withoutHashtag: only ff2f2f is accepted
enum HexColorValidatorMode { both, withHashtag, withoutHashtag }

/// Checks whether a given hex color string is valid. Null is deemed as an acceptable
/// url.

class HexColorValidator extends ValidatorWithStaticError<String> {
  const HexColorValidator(
    String error, {
    this.mode = HexColorValidatorMode.withHashtag,
  }) : super(error);

  final HexColorValidatorMode mode;

  @override
  bool innerValidate(String? value) {
    final String regex;

    switch (mode) {
      case HexColorValidatorMode.both:
        regex = hexRegexWithBoth;
        break;
      case HexColorValidatorMode.withHashtag:
        regex = hexRegexWithHashtag;
        break;
      case HexColorValidatorMode.withoutHashtag:
        regex = hexRegexWithoutHashtag;
        break;
    }

    return value == null || RegExp(regex).hasMatch(value);
  }
}

/// Checks whether a given value isn't null.
class NotNullValidator<T> extends ValidatorWithStaticError<T> {
  const NotNullValidator(String error) : super(error);

  @override
  bool innerValidate(T? value) => value != null;
}

/// Checks whether a given value is an integer.
class IsIntegerValidator<T extends num> extends ValidatorWithStaticError<T> {
  IsIntegerValidator(String error) : super(error);

  @override
  bool innerValidate(T? value) => value?.toInt() == value;
}

/// Checks whether a given num is greater (or equal) than a minimum value.
class MinValueValidator<T extends num> extends ValidatorWithStaticError<T> {
  MinValueValidator(String error, this.minimum) : super(error);

  final num minimum;

  @override
  bool innerValidate(T? value) => value == null || value >= minimum;
}

/// Checks whether a given num is smaller (or equal) than a maximum value.
class MaxValueValidator<T extends num> extends ValidatorWithStaticError<T> {
  MaxValueValidator(String error, this.maximum) : super(error);

  final num maximum;

  @override
  bool innerValidate(T? value) => value == null || value <= maximum;
}

/// Checks whether a given string isn't empty.
class NotEmptyStringValidator extends ValidatorWithStaticError<String> {
  NotEmptyStringValidator(String error) : super(error);

  @override
  bool innerValidate(String? value) => value != null && value.isNotEmpty;
}

/// Checks whether a given value isn't empty.
class NotEmptyListValidator<T> extends ValidatorWithStaticError<List<T>> {
  NotEmptyListValidator(String error) : super(error);

  @override
  bool innerValidate(List? value) => value != null && value.isNotEmpty;
}

/// Checks whether a given string possess a minimum length.
class MinimumStringLengthValidator extends Validator<String> {
  const MinimumStringLengthValidator(this.minStringLength, this.error);

  final String Function(String? value) error;

  final int minStringLength;

  @override
  String? validate(String? value) {
    if (value == null || value.length < minStringLength) return error(value);

    return null;
  }
}

/// Checks whether the value of a given field equals the value of another field.
class SameAsFieldValidator<T> extends ValidatorWithStaticError<T> {
  const SameAsFieldValidator(this.field, String error) : super(error);

  final Field field;

  @override
  bool innerValidate(T? value) {
    return value == field.value;
  }
}

/// Checks whether the value of a givGreaterThanFieldValidator of another field.
class GreaterThanFieldValidator<T extends num>
    extends ValidatorWithStaticError<T> {
  GreaterThanFieldValidator(this.getValue, String error) : super(error);

  final T? Function() getValue;

  @override
  bool innerValidate(T? value) {
    final otherValue = getValue();
    if (value != null && otherValue != null) {
      return value >= otherValue;
    }
    return false;
  }
}

/// Checks whether a given string only comports alphanumerical characters.
class AlphanumericValidator extends ValidatorWithStaticError<String> {
  const AlphanumericValidator(String error) : super(error);

  @override
  bool innerValidate(String? value) =>
      value == null || RegExp(alphaNumericRegex).hasMatch(value);
}

/// Checks whether an email string is valid.
class EmailValidator extends ValidatorWithStaticError<String> {
  const EmailValidator(String error) : super(error);

  @override
  bool innerValidate(String? value) {
    return value == null || RegExp(emailRegex).hasMatch(value.trim());
  }
}

/// Checks whether a boolean value is set to true.
class ShouldBeTrueValidator extends ValidatorWithStaticError<bool> {
  const ShouldBeTrueValidator(String error) : super(error);

  @override
  bool innerValidate(bool? value) {
    return value ?? false;
  }
}

class FormValidator extends Validator<TemplateForm> {
  const FormValidator();

  @override
  String? validate(TemplateForm value) {
    return value.isComplete() ? null : 'ERROR';
  }
}
