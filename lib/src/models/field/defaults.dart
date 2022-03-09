import 'package:flutter_auto_form/src/configuration/typedef.dart';
import 'package:flutter_auto_form/src/models/validators/validator.dart';
import 'package:flutter_auto_form/src/widgets/fields/fields.dart';

import 'field.dart';

/// The default [Field] extended class used to represent a form's text field.
class AFTextField<T extends Object> extends Field<T> {
  AFTextField({
    required String id,
    required String name,
    required List<Validator<T>> validators,
    required this.type,
    this.maxLines = 1,
    T? value,
  }) : super(id, name, validators) {
    super.value = value;
  }

  /// Depending on the value of this field, the widget's related instance will act differently.
  ///(For instance, if you choose the password option it will display a hide/display icon).
  final AFTextFieldType type;

  /// {@macro flutter.widgets.editableText.maxLines}
  final int? maxLines;

  @override
  T? parser(T? unparsedValue) {
    if (type == AFTextFieldType.EMAIL) {
      return (unparsedValue as String?)?.trim() as T?;
    } else {
      return unparsedValue;
    }
  }

  @override
  final FieldWidgetConstructor widgetConstructor = AFTextFieldWidget.new;
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

class AFSelectField<T extends Object> extends Field<T> {
  AFSelectField({
    required String id,
    required String name,
    required List<Validator<Object?>> validators,
    required this.values,
    required this.textBuilder,
    required T value,
  }) : super(
          id,
          name,
          validators,
        ) {
    super.value = value;
  }

  final List<T> values;

  final String Function(T value) textBuilder;

  @override
  T? parser(T? unparsedValue) {
    assert(unparsedValue != null);

    return unparsedValue;
  }

  @override
  final FieldWidgetConstructor widgetConstructor = SelectFieldWidget.new;
}

class AFBooleanField extends Field<bool> {
  AFBooleanField({
    required String id,
    required String name,
    required List<Validator<bool?>> validators,
    bool value = false,
  }) : super(
          id,
          name,
          validators,
        ) {
    super.value = value;
  }

  @override
  bool? parser(bool unparsedValue) => unparsedValue;

  @override
  final FieldWidgetConstructor widgetConstructor = BooleanFieldWidget.new;
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
