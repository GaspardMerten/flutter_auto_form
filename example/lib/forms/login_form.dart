import 'package:flutter_auto_form/flutter_auto_form.dart';

class LoginForm extends TemplateForm {
  @override
  final List<Field> fields = [
    AFTextField(
      'identifier',
      'Identifier',
      [
        MinimumStringLengthValidator(
          5,
          (e) => 'Min 5 characters, currently ${e?.length ?? 0} ',
        )
      ],
      AFTextFieldType.USERNAME,
    ),
    AFTextField(
      'password',
      'Password',
      [
        MinimumStringLengthValidator(
          6,
          (e) => 'Min 6 characters, currently ${e?.length ?? 0} ',
        )
      ],
      AFTextFieldType.PASSWORD,
    )
  ];
}
