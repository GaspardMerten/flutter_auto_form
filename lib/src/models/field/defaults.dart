import 'package:flutter_auto_form/src/models/validator/validator.dart';

import 'field.dart';

/// The default [Field] extended class used to represent a form's text field.
class AFTextField<T extends Object> extends Field<T> {
  AFTextField({
    required String id,
    required String name,
    required List<Validator<T>> validators,
    required this.type,
    T? value,
  }) : super(id, name, validators) {
    super.value = value;
  }

  /// Depending on the value of this field, the widget's related instance will act differently.
  ///(For instance, if you choose the password option it will display a hide/display icon).
  final AFTextFieldType type;

  @override
  T? parser(T? unparsedValue) {
    if (type == AFTextFieldType.EMAIL) {
      return (unparsedValue as String?)?.trim() as T?;
    } else {
      return unparsedValue;
    }
  }
}

/// The default [Field] extended class used to represent a form's number field.
class AFNumberField<T extends num> extends AFTextField<T> {
  AFNumberField({
    required String id,
    required String name,
    required List<Validator<T>> validators,
    T? value,
  }) : super(
          id: id,
          name: name,
          validators: validators,
          type: AFTextFieldType.NUMBER,
          value: value,
        );

  @override
  T? parser(Object? unparsedValue) {
    if (unparsedValue.runtimeType == String) {
      unparsedValue = num.tryParse(unparsedValue as String);
    }

    final num? unparsedValueAsNum = unparsedValue as num?;

    if (T == int) {
      return unparsedValueAsNum?.toInt() as T?;
    } else if (T == double) {
      return unparsedValueAsNum?.toDouble() as T?;
    }

    return unparsedValueAsNum as T?;
  }
}

class AFSearchModelField<T extends Object> extends Field<T> {
  AFSearchModelField({
    required String id,
    required String name,
    required List<Validator<Object?>> validators,
    required this.search,
  }) : super(
          id,
          name,
          validators,
        );

  final Future<List<T>> Function(String? query) search;

  @override
  T? parser(T? unparsedValue) => unparsedValue;
}

class AFBooleanField extends Field<bool> {
  AFBooleanField({
    required String id,
    required String name,
    required List<Validator<Object?>> validators,
  }) : super(
          id,
          name,
          validators,
        );

  @override
  bool? parser(bool unparsedValue) => unparsedValue;
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
  COLOR,
  URL
}
