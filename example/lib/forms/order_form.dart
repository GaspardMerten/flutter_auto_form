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
    AFSelectField(
      id: 'select',
      name: 'Select',
      validators: [],
      values: [1, 2],
      textBuilder: (e) => e.toString(),
      value: 1,
    ),
    AFMultipleFormField(
      id: 'other_orders',
      name: 'Other orders (no meaning..)',
      formGenerator: () => OrderForm(),
    ),
  ];
}
