import 'package:flutter_auto_form/flutter_auto_form.dart';
import 'package:flutter_test/flutter_test.dart';

class _AlwaysCompleteForm extends TemplateForm {
  @override
  bool isComplete() => true;

  @override
  List<Field<Object>> get fields => [];
}

class _NeverCompleteForm extends _AlwaysCompleteForm {
  @override
  bool isComplete() => false;
}

void main() {
  test('Not null validator validates properly', () {
    const String? propreValue = 'value';

    expect(NotNullValidator('error').validate(propreValue), equals(null));

    const String? improperValue = null;

    expect(
      NotNullValidator('error').validate(improperValue),
      equals('error'),
    );
  });

  test('Minimum string length validates properly', () {
    const String properLengthOne = 'gaspard';
    const String properLengthTwo = 'gaspa';

    expect(
      MinimumStringLengthValidator(5, (_) => 'error').validate(properLengthOne),
      equals(null),
    );
    expect(
      MinimumStringLengthValidator(5, (_) => 'error').validate(properLengthTwo),
      equals(null),
    );

    const String notProperLength = 'gasp';

    expect(
      MinimumStringLengthValidator(
        5,
        (String? value) => '$value',
      ).validate(notProperLength),
      equals(notProperLength),
    );
  });
  test('Same as field validator validates properly', () {
    const String dValue = 'value';

    final AFTextField textField = AFTextField(
      id: 'id',
      name: 'name',
      validators: [],
      type: AFTextFieldType.TEXT,
      value: dValue,
    );

    expect(
      SameAsFieldValidator(textField, 'error').validate(dValue),
      equals(null),
    );

    const String notSameValue = 'notTheSame';

    expect(
      SameAsFieldValidator(textField, 'error').validate(notSameValue),
      equals('error'),
    );
  });
  test('AlphanumericV validator validates properly', () {
    const String properAlphanumeric = 'gaspard';
    const String properAlphanumericWithNumber = 'gaspard1';
    const String properAlphanumericWithCapitalizedLetters = 'Gaspard';

    expect(
      AlphanumericValidator('error').validate(properAlphanumeric),
      equals(null),
    );
    expect(
      AlphanumericValidator('error').validate(properAlphanumericWithNumber),
      equals(null),
    );
    expect(
      AlphanumericValidator('error')
          .validate(properAlphanumericWithCapitalizedLetters),
      equals(null),
    );

    const String improperAlphanumericOne = 'gaspard@merten';
    const String improperAlphanumericTwo = 'gaspard merten';
    const String improperAlphanumericThree = 'gaspard.merten';

    expect(
      AlphanumericValidator('error').validate(improperAlphanumericOne),
      equals('error'),
    );
    expect(
      AlphanumericValidator('error').validate(improperAlphanumericTwo),
      equals('error'),
    );
    expect(
      AlphanumericValidator('error').validate(improperAlphanumericThree),
      equals('error'),
    );
  });
  test('Should be true validator validates properly', () {
    const bool value = true;

    expect(ShouldBeTrueValidator('error').validate(value), equals(null));

    const bool falseValue = false;

    expect(
      ShouldBeTrueValidator('error').validate(falseValue),
      equals('error'),
    );
  });
  test('Email validator validates properly', () {
    const String properEmail = 'gaspard@merten.be';
    const String properEmailWithCapitalizedLetters = 'GasparD@Merten.BE';

    expect(EmailValidator('error').validate(properEmail), equals(null));
    expect(
      EmailValidator('error').validate(properEmailWithCapitalizedLetters),
      equals(null),
    );

    const String improperEmailOne = 'gaspard@merten';
    const String improperEmailTwo = 'gaspard.merten.be';

    expect(
      EmailValidator('error').validate(improperEmailOne),
      equals('error'),
    );
    expect(
      EmailValidator('error').validate(improperEmailTwo),
      equals('error'),
    );
  });

  test('Form validator validates properly', () {
    final _AlwaysCompleteForm _alwaysCompleteForm = _AlwaysCompleteForm();

    expect(FormValidator().validate(_alwaysCompleteForm), equals(null));

    final _NeverCompleteForm _neverCompleteForm = _NeverCompleteForm();
    expect(FormValidator().validate(_neverCompleteForm), equals('ERROR'));
  });

  test('URL Validator validates properly', () {
    const String properURL = 'https://www.merten.be';

    expect(URLValidator('error').validate(properURL), equals(null));

    const String improperURLOne = 'gaspard@merten.be';
    const String improperURLTwo = 'gaspard.merten.be';

    expect(
      URLValidator('error').validate(improperURLOne),
      equals('error'),
    );
    expect(
      URLValidator('error').validate(improperURLTwo),
      equals('error'),
    );
  });

  test('Hex Color Validator validates properly - Default mode, with #', () {
    const String properHexColorOne = '#f9232f';
    const String properHexColorTwo = '#F9232F';

    expect(
      HexColorValidator('error').validate(properHexColorOne),
      equals(null),
    );
    expect(
      HexColorValidator('error').validate(properHexColorTwo),
      equals(null),
    );

    const String improperHexColorOne = '#f9232x';
    const String improperHexColorTwo = 'f9232aa';
    const String improperHexColorThree = 'f9232a';

    expect(
      HexColorValidator('error').validate(improperHexColorOne),
      equals('error'),
    );
    expect(
      HexColorValidator('error').validate(improperHexColorTwo),
      equals('error'),
    );
    expect(
      HexColorValidator('error').validate(improperHexColorThree),
      equals('error'),
    );
  });
  test('Hex Color Validator validates properly - Without #', () {
    const String properHexColorOne = 'f9232f';
    const String properHexColorTwo = 'F9232F';

    expect(
      HexColorValidator(
        'error',
        mode: HexColorValidatorMode.withoutHashtag,
      ).validate(properHexColorOne),
      equals(null),
    );
    expect(
      HexColorValidator(
        'error',
        mode: HexColorValidatorMode.withoutHashtag,
      ).validate(properHexColorTwo),
      equals(null),
    );

    const String improperHexColorOne = '#f9232a';
    const String improperHexColorTwo = 'f9232aa';
    const String improperHexColorThree = 'f9232x';

    expect(
      HexColorValidator(
        'error',
        mode: HexColorValidatorMode.withoutHashtag,
      ).validate(improperHexColorOne),
      equals('error'),
    );
    expect(
      HexColorValidator(
        'error',
        mode: HexColorValidatorMode.withoutHashtag,
      ).validate(improperHexColorTwo),
      equals('error'),
    );
    expect(
      HexColorValidator(
        'error',
        mode: HexColorValidatorMode.withoutHashtag,
      ).validate(improperHexColorThree),
      equals('error'),
    );
  });
  test('Hex Color Validator validates properly - Both mode (with & without #)',
      () {
    const String properHexColorOne = 'f9232f';
    const String properHexColorTwo = 'F9232F';
    const String properHexColorThree = '#f9232f';
    const String properHexColorFour = '#F9232F';

    expect(
      HexColorValidator(
        'error',
        mode: HexColorValidatorMode.both,
      ).validate(properHexColorOne),
      equals(null),
    );
    expect(
      HexColorValidator(
        'error',
        mode: HexColorValidatorMode.both,
      ).validate(properHexColorTwo),
      equals(null),
    );

    expect(
      HexColorValidator(
        'error',
        mode: HexColorValidatorMode.both,
      ).validate(properHexColorThree),
      equals(null),
    );
    expect(
      HexColorValidator(
        'error',
        mode: HexColorValidatorMode.both,
      ).validate(properHexColorFour),
      equals(null),
    );

    const String improperHexColorOne = '#f9232x';
    const String improperHexColorTwo = 'f9232aa';
    const String improperHexColorThree = 'f9232x';

    expect(
      HexColorValidator(
        'error',
        mode: HexColorValidatorMode.both,
      ).validate(improperHexColorOne),
      equals('error'),
    );
    expect(
      HexColorValidator(
        'error',
        mode: HexColorValidatorMode.both,
      ).validate(improperHexColorTwo),
      equals('error'),
    );
    expect(
      HexColorValidator(
        'error',
        mode: HexColorValidatorMode.both,
      ).validate(improperHexColorThree),
      equals('error'),
    );
  });
}
