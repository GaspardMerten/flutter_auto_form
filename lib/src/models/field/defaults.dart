import 'package:flutter_auto_form/src/models/validator/validator.dart';

import 'field.dart';

/// The default [Field] extended class used to represent a form's text field.
class AFTextField<T extends Object> extends Field<T> {
  AFTextField(
    String id,
    String name,
    List<Validator<T>> validators,
    this.type,
  ) : super(id, name, validators);

  /// Depending on the value of this field, the widget's related instance will act differently.
  ///(For instance, if you choose the password option it will display a hide/display icon).
  final AFTextFieldType type;

  @override
  set value(T? _value) {
    if (type == AFTextFieldType.EMAIL) {
      super.value = (_value as String?)?.trim() as T;
    } else {
      super.value = _value;
    }
  }
}

/// The default [Field] extended class used to represent a form's text field.
class AFNumberField<T extends num> extends AFTextField<T> {
  AFNumberField(
    String id,
    String name,
    List<Validator<T>> validators,
  ) : super(id, name, validators, AFTextFieldType.NUMBER);

  /// Depending on the value of this field, the widget's related instance will act differently.
  ///(For instance, if you choose the password option it will display a hide/display icon).
}

/// The different types of field for the [AFTextField].
enum AFTextFieldType {
  TEXT,
  NUMBER,
  PASSWORD,
  EMAIL,
  USERNAME,
  NEW_PASSWORD,
  NEW_USERNAME,
  URL
}
