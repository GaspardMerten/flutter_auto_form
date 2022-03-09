import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_auto_form/src/configuration/typedef.dart';
import 'package:flutter_auto_form/src/models/field/field_context.dart';
import 'package:flutter_auto_form/src/models/form.dart';
import 'package:flutter_auto_form/src/models/validators/validator.dart';
import 'package:flutter_auto_form/src/widgets/fields/fields.dart';
import 'package:flutter_auto_form/src/widgets/fields/text_field.dart';

import 'field.dart';

/// The default [Field] extended class used to represent a form's text field.
class AFTextField<T extends Object> extends Field<T> {
  AFTextField({
    required String id,
    required String name,
    required List<Validator<T>> validators,
    required this.type,
    T? value,
    this.maxLines = 1,
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

List<String> getAutoFillHintsFromFieldType(AFTextField field) {
  String? autoFillHint;

  switch (field.type) {
    case AFTextFieldType.PASSWORD:
      autoFillHint = AutofillHints.password;
      break;
    case AFTextFieldType.EMAIL:
      autoFillHint = AutofillHints.email;
      break;
    case AFTextFieldType.USERNAME:
      autoFillHint = AutofillHints.username;
      break;
    case AFTextFieldType.NEW_PASSWORD:
      autoFillHint = AutofillHints.newPassword;
      break;
    case AFTextFieldType.NEW_USERNAME:
      autoFillHint = AutofillHints.newUsername;
      break;
    default:
      break;
  }

  return [if (autoFillHint != null) autoFillHint];
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

class SimpleFile {
  SimpleFile(this.name, this.bytes);

  final String name;
  final Uint8List? bytes;
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

  @override
  final FieldWidgetConstructor widgetConstructor = SearchModelFieldWidget.new;
}

class AFSearchMultipleModelsField<T extends Object> extends Field<List<T>> {
  AFSearchMultipleModelsField({
    required String id,
    required String name,
    required List<Validator<List<Object?>>> validators,
    required this.search,
  }) : super(
          id,
          name,
          validators,
        );

  final Future<List<T>> Function(String? query) search;

  @override
  List<T>? parser(covariant List<Object>? unparsedValue) {
    return unparsedValue?.cast<T>();
  }

  @override
  final FieldWidgetConstructor widgetConstructor =
      SearchMultipleModelsField.new;
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

class AFFormField<T extends TemplateForm> extends Field<Map<String, Object?>> {
  AFFormField({
    required String id,
    required String name,
    required this.formGenerator,
    this.required = true,
  }) : super(
          id,
          name,
          [],
        );

  final bool required;

  final T Function() formGenerator;

  T? form;

  @override
  Map<String, Object?>? get value => form?.toMap();

  @override
  Map<String, Object?>? parser(Map<String, Object?>? unparsedValue) =>
      unparsedValue;

  @override
  final FieldWidgetConstructor widgetConstructor = AFTextFieldWidget.new;
}

class AFMultipleFormField<T extends TemplateForm>
    extends Field<List<Map<String, Object?>>> {
  AFMultipleFormField({
    required String id,
    required String name,
    required this.formGenerator,
  }) : super(
          id,
          name,
          [],
        );

  final T Function() formGenerator;

  final List<T> forms = [];

  @override
  List<Map<String, Object?>> get value => forms.map((e) => e.toMap()).toList();

  @override
  List<Map<String, Object?>> parser(List<Map<String, Object?>>? unparsedValue) {
    return unparsedValue ?? [];
  }

  @override
  final FieldWidgetConstructor widgetConstructor =
      AFMultipleFormFieldWidget.new;
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
