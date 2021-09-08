import 'package:flutter_auto_form/flutter_auto_form.dart';

class RegistrationForm extends TemplateForm {
  final Field passwordField = AFTextField(
    'password',
    'Password',
    [
      MinimumStringLengthValidator(
        6,
        (e) => 'Min 6 cara. Currently: ${e?.length ?? 0}',
      )
    ],
    AFTextFieldType.NEW_PASSWORD,
  );

  @override
  late List<Field> fields = [
    AFTextField(
        'email',
        'E-mail address',
        [
          EmailValidator(
            'Invalid email',
          ),
        ],
        AFTextFieldType.EMAIL),
    passwordField,
    AFTextField(
      'verify',
      'Confirm password',
      [
        SameAsFieldValidator(
          'Passwords not matching',
          passwordField,
        ),
      ],
      AFTextFieldType.NEW_PASSWORD,
    ),
  ];
}
