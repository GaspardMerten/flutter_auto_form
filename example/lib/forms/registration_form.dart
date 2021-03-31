import 'package:flutter_auto_form/flutter_auto_form.dart';

class RegistrationForm extends TemplateForm {
  RegistrationForm() {
    final Field passwordField = AutoFormTextField(
      'password',
      'Password',
      [
        MinimumStringLengthValidator(
          6,
          (e) => 'Min 6 cara. Currently: ${e.length}',
        )
      ],
      AutoFormTextFieldType.NEW_PASSWORD,
    );

    fields = [
      AutoFormTextField(
          'email',
          'E-mail address',
          [
            EmailValidator(
              'Invalid email',
            ),
          ],
          AutoFormTextFieldType.EMAIL),
      passwordField,
      AutoFormTextField(
        'verify',
        'Confirm password',
        [
          SameAsFieldValidator(
            'Passwords not matching',
            passwordField,
          ),
        ],
        AutoFormTextFieldType.NEW_PASSWORD,
      ),
    ];
  }

  @override
  List<Field> fields;
}
