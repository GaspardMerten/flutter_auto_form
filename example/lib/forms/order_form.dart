import 'package:auto_form_example/api/fake_api.dart';
import 'package:auto_form_example/forms/registration_form.dart';
import 'package:flutter_auto_form/flutter_auto_form.dart';

class OrderForm extends TemplateForm {
  @override
  final List<Field<Object>> fields = [
    AFNumberField<int>(
      id: 'order-number',
      name: 'Order\'s number',
      validators: [NotNullValidator('Please enter a valid integer')],
    ),
    AFBooleanField(
      id: 'payed',
      name: 'Is payed',
      validators: [],
      value: false,
    ),
    AFSelectField(
      id: 'select',
      name: 'Select',
      validators: [],
      values: [1, 2],
      textBuilder: (e) => e.toString(),
      value: 1,
    ),
    AFSearchMultipleModelsField(
      id: 'books',
      name: 'Books',
      validators: [NotEmptyListValidator('Please select at least one book')],
      search: searchBook,
    ),
    AFFormField('form', 'Form field', [], RegistrationForm()),
    AFMultipleFormField(
        'multiple_form', 'Form field 2', [], () => RegistrationForm()),
  ];
}
