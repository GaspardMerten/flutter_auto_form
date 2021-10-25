import 'package:flutter_auto_form/flutter_auto_form.dart';
import 'package:flutter_auto_form/src/models/field/field.dart';
import 'package:flutter_auto_form/src/models/regex.dart';
import 'package:flutter_auto_form/src/models/validators/validator.dart';

class URLValidator extends ValidatorWithStaticError<String> {
  const URLValidator(String error) : super(error);

  @override
  bool innerValidate(String? value) {
    return value == null || RegExp(urlRegex).allMatches(value).isNotEmpty;
  }
}

enum HexColorValidatorMode { both, withHashtag, withoutHashtag }

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

    return value != null && RegExp(regex).hasMatch(value);
  }
}

class NotNullValidator<T> extends ValidatorWithStaticError<T> {
  const NotNullValidator(String error) : super(error);

  @override
  bool innerValidate(T? value) => value != null;
}

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

class SameAsFieldValidator<T> extends ValidatorWithStaticError<T> {
  const SameAsFieldValidator(this.field, String error) : super(error);

  final Field field;

  @override
  bool innerValidate(T? value) => value == field.value;
}

class AlphanumericValidator extends ValidatorWithStaticError<String> {
  const AlphanumericValidator(String error) : super(error);

  @override
  bool innerValidate(String? value) =>
      value != null && RegExp(alphaNumericRegex).hasMatch(value);
}

class EmailValidator extends ValidatorWithStaticError<String> {
  const EmailValidator(String error) : super(error);

  @override
  bool innerValidate(String? value) {
    return value != null && RegExp(emailRegex).hasMatch(value.trim());
  }
}

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
