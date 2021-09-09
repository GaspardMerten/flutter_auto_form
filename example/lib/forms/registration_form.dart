import 'package:flutter_auto_form/flutter_auto_form.dart';

class RegistrationForm extends TemplateForm {
  final Field passwordField = AFTextField(
    id: 'password',
    name: 'Password',
    validators: [
      MinimumStringLengthValidator(
        6,
        (e) => 'Min 6 cara. Currently: ${e?.length ?? 0}',
      )
    ],
    type: AFTextFieldType.NEW_PASSWORD,
  );

  @override
  late List<Field> fields = [
    AFTextField(
      id: 'email',
      name: 'E-mail address',
      validators: [
        EmailValidator(
          'Invalid email',
        ),
      ],
      type: AFTextFieldType.EMAIL,
    ),
    passwordField,
    AFTextField(
      id: 'verify',
      name: 'Confirm password',
      validators: [
        SameAsFieldValidator(
          'Passwords not matching',
          passwordField,
        ),
      ],
      type: AFTextFieldType.NEW_PASSWORD,
    ),
  ];
}
