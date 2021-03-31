import 'package:flutter_auto_form/src/models/validator/validator.dart';

import 'field.dart';

class AutoFormTextField extends Field {
  AutoFormTextField(
    String id,
    String name,
    List<Validator> validators,
    this.type,
  ) : super(id, name, validators);

  final AutoFormTextFieldType type;
}

enum AutoFormTextFieldType {
  TEXT,
  NUMBER,
  PASSWORD,
  EMAIL,
  USERNAME,
  NEW_PASSWORD,
  NEW_USERNAME,
  URL
}
