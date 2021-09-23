import 'package:flutter_auto_form/src/models/field/field.dart';
import 'package:flutter_auto_form/src/models/regex.dart';
import 'package:flutter_auto_form/src/models/validator/validator.dart';

class URLValidator extends ValidatorWithStaticError<String> {
  URLValidator(String error) : super(error);

  @override
  bool innerValidate(String? value) {
    return value == null || RegExp(emailRegex).allMatches(value).isNotEmpty;
  }
}

enum HexColorValidatorMode { both, withHashtag, withoutHashtag }

class HexColorValidator extends ValidatorWithStaticError<String> {
  HexColorValidator(
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

    return value != null && value.length == 6 && RegExp(regex).hasMatch(value);
  }
}

class NotNullValidator<T> extends ValidatorWithStaticError<T> {
  NotNullValidator(String error) : super(error);

  @override
  bool innerValidate(T? value) => value != null;
}

class MinimumStringLengthValidator extends Validator<String> {
  MinimumStringLengthValidator(this.minStringLength, this.error);

  final String Function(String? value) error;

  final int minStringLength;

  @override
  String? validate(String? value) {
    if (value == null || value.length < minStringLength) return error(value);

    return null;
  }
}

class SameAsFieldValidator<T> extends ValidatorWithStaticError<T> {
  SameAsFieldValidator(String error, this.field) : super(error);

  final Field field;

  @override
  bool innerValidate(T? value) => value == field.value;
}

class AlphanumericValidator extends ValidatorWithStaticError<String> {
  AlphanumericValidator(String error) : super(error);

  @override
  bool innerValidate(String? value) =>
      value != null && RegExp(alphaNumericRegex).hasMatch(value);
}

class EmailValidator extends ValidatorWithStaticError<String> {
  EmailValidator(String error) : super(error);

  @override
  bool innerValidate(String? value) {
    return value != null && RegExp(emailRegex).hasMatch(value.trim());
  }
}

class ShouldBeTrueValidator extends ValidatorWithStaticError<bool> {
  ShouldBeTrueValidator(String error) : super(error);

  @override
  bool innerValidate(bool? value) {
    return value ?? false;
  }
}
