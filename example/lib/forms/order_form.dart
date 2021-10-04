import 'package:auto_form_example/api/fake_api.dart';
import 'package:auto_form_example/entities/book.dart';
import 'package:flutter_auto_form/flutter_auto_form.dart';

class OrderForm extends TemplateForm {
  @override
  final List<Field<Object>> fields = [
    AFNumberField<int>(
      id: 'order-number',
      name: 'Order\'s number',
      validators: [NotNullValidator('Please enter a valid integer')],
    ),
    AFSearchModelField<Book>(
      id: 'book',
      name: 'Book',
      validators: [NotNullValidator('Please select a book')],
      search: searchBook,
    ),
    AFBooleanField(
      id: 'payed',
      name: 'Is payed',
      validators: [],
      value: false,
    ),
    AFFileField(id: 'file', name: 'File', validators: [])
  ];
}
