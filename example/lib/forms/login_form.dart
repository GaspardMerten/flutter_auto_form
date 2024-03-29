import 'package:flutter_auto_form/flutter_auto_form.dart';

class LoginForm extends TemplateForm {
  @override
  final List<Field> fields = [
    AFTextField(
      id: 'identifier',
      name: 'Identifier',
      validators: [
        MinimumStringLengthValidator(
          5,
          (e) => 'Min 5 characters, currently ${e?.length ?? 0} ',
        )
      ],
      type: AFTextFieldType.username,
    ),
    AFTextField(
      id: 'password',
      name: 'Password',
      validators: [
        MinimumStringLengthValidator(
          6,
          (e) => 'Min 6 characters, currently ${e?.length ?? 0} ',
        )
      ],
      type: AFTextFieldType.password,
    ),
    AFBooleanField(
      id: 'accept-condition',
      name: 'Accept terms',
      validators: [ShouldBeTrueValidator('Please accept terms')],
      value: false,
    ),
  ];
}
