import 'package:flutter_auto_form/flutter_auto_form.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Not null validator validates properly', () {
    const String propreValue = 'value';

    expect(const NotNullValidator('error').validate(propreValue), equals(null));

    const String? improperValue = null;

    expect(
      const NotNullValidator('error').validate(improperValue),
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
      type: AFTextFieldType.text,
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
      const AlphanumericValidator('error').validate(properAlphanumeric),
      equals(null),
    );
    expect(
      const AlphanumericValidator('error')
          .validate(properAlphanumericWithNumber),
      equals(null),
    );
    expect(
      const AlphanumericValidator('error')
          .validate(properAlphanumericWithCapitalizedLetters),
      equals(null),
    );

    const String improperAlphanumericOne = 'gaspard@merten';
    const String improperAlphanumericTwo = 'gaspard merten';
    const String improperAlphanumericThree = 'gaspard.merten';

    expect(
      const AlphanumericValidator('error').validate(improperAlphanumericOne),
      equals('error'),
    );
    expect(
      const AlphanumericValidator('error').validate(improperAlphanumericTwo),
      equals('error'),
    );
    expect(
      const AlphanumericValidator('error').validate(improperAlphanumericThree),
      equals('error'),
    );
  });
  test('Should be true validator validates properly', () {
    const bool value = true;

    expect(const ShouldBeTrueValidator('error').validate(value), equals(null));

    const bool falseValue = false;

    expect(
      const ShouldBeTrueValidator('error').validate(falseValue),
      equals('error'),
    );
  });
  test('Email validator validates properly', () {
    const String properEmail = 'gaspard@merten.be';
    const String properEmailWithCapitalizedLetters = 'GasparD@Merten.BE';

    expect(const EmailValidator('error').validate(properEmail), equals(null));
    expect(
      const EmailValidator('error').validate(properEmailWithCapitalizedLetters),
      equals(null),
    );

    const String improperEmailOne = 'gaspard@merten';
    const String improperEmailTwo = 'gaspard.merten.be';

    expect(
      const EmailValidator('error').validate(improperEmailOne),
      equals('error'),
    );
    expect(
      const EmailValidator('error').validate(improperEmailTwo),
      equals('error'),
    );
  });

  test('URL Validator validates properly', () {
    const String properURL = 'https://www.merten.be';

    expect(const URLValidator('error').validate(properURL), equals(null));

    const String improperURLOne = 'gaspard@merten.be';
    const String improperURLTwo = 'gaspard.merten.be';

    expect(
      const URLValidator('error').validate(improperURLOne),
      equals('error'),
    );
    expect(
      const URLValidator('error').validate(improperURLTwo),
      equals('error'),
    );
  });

  test('Hex Color Validator validates properly - Default mode, with #', () {
    const String properHexColorOne = '#f9232f';
    const String properHexColorTwo = '#F9232F';

    expect(
      const HexColorValidator('error').validate(properHexColorOne),
      equals(null),
    );
    expect(
      const HexColorValidator('error').validate(properHexColorTwo),
      equals(null),
    );

    const String improperHexColorOne = '#f9232x';
    const String improperHexColorTwo = 'f9232aa';
    const String improperHexColorThree = 'f9232a';

    expect(
      const HexColorValidator('error').validate(improperHexColorOne),
      equals('error'),
    );
    expect(
      const HexColorValidator('error').validate(improperHexColorTwo),
      equals('error'),
    );
    expect(
      const HexColorValidator('error').validate(improperHexColorThree),
      equals('error'),
    );
  });
  test('Hex Color Validator validates properly - Without #', () {
    const String properHexColorOne = 'f9232f';
    const String properHexColorTwo = 'F9232F';

    expect(
      const HexColorValidator(
        'error',
        mode: HexColorValidatorMode.withoutHashtag,
      ).validate(properHexColorOne),
      equals(null),
    );
    expect(
      const HexColorValidator(
        'error',
        mode: HexColorValidatorMode.withoutHashtag,
      ).validate(properHexColorTwo),
      equals(null),
    );

    const String improperHexColorOne = '#f9232a';
    const String improperHexColorTwo = 'f9232aa';
    const String improperHexColorThree = 'f9232x';

    expect(
      const HexColorValidator(
        'error',
        mode: HexColorValidatorMode.withoutHashtag,
      ).validate(improperHexColorOne),
      equals('error'),
    );
    expect(
      const HexColorValidator(
        'error',
        mode: HexColorValidatorMode.withoutHashtag,
      ).validate(improperHexColorTwo),
      equals('error'),
    );
    expect(
      const HexColorValidator(
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
      const HexColorValidator(
        'error',
        mode: HexColorValidatorMode.both,
      ).validate(properHexColorOne),
      equals(null),
    );
    expect(
      const HexColorValidator(
        'error',
        mode: HexColorValidatorMode.both,
      ).validate(properHexColorTwo),
      equals(null),
    );

    expect(
      const HexColorValidator(
        'error',
        mode: HexColorValidatorMode.both,
      ).validate(properHexColorThree),
      equals(null),
    );
    expect(
      const HexColorValidator(
        'error',
        mode: HexColorValidatorMode.both,
      ).validate(properHexColorFour),
      equals(null),
    );

    const String improperHexColorOne = '#f9232x';
    const String improperHexColorTwo = 'f9232aa';
    const String improperHexColorThree = 'f9232x';

    expect(
      const HexColorValidator(
        'error',
        mode: HexColorValidatorMode.both,
      ).validate(improperHexColorOne),
      equals('error'),
    );
    expect(
      const HexColorValidator(
        'error',
        mode: HexColorValidatorMode.both,
      ).validate(improperHexColorTwo),
      equals('error'),
    );
    expect(
      const HexColorValidator(
        'error',
        mode: HexColorValidatorMode.both,
      ).validate(improperHexColorThree),
      equals('error'),
    );
  });
}
