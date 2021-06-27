import 'package:flutter_auto_form/src/models/validator/validator.dart';

import 'field.dart';

/// The default [Field] extended class used to represent a form's text field.
class AutoFormTextField extends Field {
  AutoFormTextField(
    String id,
    String name,
    List<Validator> validators,
    this.type,
  ) : super(id, name, validators);

  /// Depending on the value of this field, the widget's related instance will act differently. 
  ///(For instance, if you choose the password option it will display a hide/display icon).
  final AutoFormTextFieldType type;
}

/// The different types of field for the [AutoFormTextField]. 
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
