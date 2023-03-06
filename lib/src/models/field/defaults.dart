import 'dart:async';

import 'package:date_field/date_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_auto_form/flutter_auto_form.dart';
import 'package:flutter_auto_form/src/widgets/fields/fields.dart';

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

/// The default [Field] extended class used to represent a form's text field.
class AFTextField<T extends Object> extends Field<T> {
  AFTextField({
    required String id,
    required String name,
    required List<Validator<T>> validators,
    required this.type,
    this.maxLines = 1,
    T? value,
  }) : super(id: id, name: name, validators: validators) {
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
  final FieldWidgetConstructor widgetBuilder = AFTextFieldWidget.new;
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

/// The default [Field] extended class used to represent a form's number field.
class AFDateField extends Field<DateTime> {
  AFDateField({
    required String id,
    required String name,
    required List<Validator<DateTime>> validators,
  }) : super(
          id: id,
          name: name,
          validators: validators,
        );

  @override
  FieldWidgetConstructor get widgetBuilder => ({
        Key? key,
        required FieldContext fieldContext,
      }) =>
          DateFieldWidget(
            fieldContext: fieldContext,
            mode: DateTimeFieldPickerMode.date,
          );

  @override
  DateTime? parser(covariant Object? unparsedValue) {
    return unparsedValue as DateTime?;
  }
}

/// The default [Field] extended class used to represent a form's number field.
class AFTimeField extends Field<DateTime> {
  AFTimeField({
    required String id,
    required String name,
    required List<Validator<DateTime>> validators,
  }) : super(
          id: id,
          name: name,
          validators: validators,
        );

  @override
  FieldWidgetConstructor get widgetBuilder => ({
        Key? key,
        required FieldContext fieldContext,
      }) =>
          DateFieldWidget(
            fieldContext: fieldContext,
            mode: DateTimeFieldPickerMode.time,
          );

  @override
  DateTime? parser(covariant Object? unparsedValue) {
    return unparsedValue as DateTime?;
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
          id: id,
          name: name,
          validators: validators,
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
  final FieldWidgetConstructor widgetBuilder = SelectFieldWidget.new;
}

class AFBooleanField extends Field<bool> {
  AFBooleanField({
    required String id,
    required String name,
    required List<Validator<bool?>> validators,
    bool value = false,
  }) : super(
          id: id,
          name: name,
          validators: validators,
        ) {
    super.value = value;
  }

  @override
  bool? parser(bool unparsedValue) => unparsedValue;

  @override
  final FieldWidgetConstructor widgetBuilder = BooleanFieldWidget.new;
}

class AFSearchModelField<T extends Object> extends Field<T> {
  AFSearchModelField({
    required String id,
    required String name,
    required List<Validator<Object?>> validators,
    required this.search,
  }) : super(id: id, name: name, validators: validators);

  final Future<List<T>> Function(String? query) search;

  @override
  T? parser(T? unparsedValue) => unparsedValue;

  @override
  FieldWidgetConstructor get widgetBuilder => SearchModelFieldWidget<T>.new;
}

class AFSearchMultipleModelsField<T extends Object> extends Field<List<T>> {
  AFSearchMultipleModelsField({
    required String id,
    required String name,
    required List<Validator<List<T>>> validators,
    required this.search,
  }) : super(id: id, name: name, validators: validators);

  final Future<List<T>> Function(String? query) search;


  @override
  List<T>? parser(covariant List? unparsedValue) {
    return unparsedValue?.cast<T>();
  }

  @override
  final FieldWidgetConstructor widgetBuilder = SearchMultipleModelsField<T>.new;
}

mixin WithForceErrorStream<T> {
  final _controller = StreamController<void>.broadcast();

  Stream<void> get forceErrorStream => _controller.stream;

  void sendForceErrorEvent() {
    _controller.add(null);
  }
}

class AFSubFormField<T extends TemplateForm> extends Field<Map>
    with WithForceErrorStream {
  AFSubFormField(
      {required String id,
      required String name,
      required List<Validator<Object?>> validators,
      required this.form})
      : super(id: id, name: name, validators: validators);

  final T form;

  @override
  final FieldWidgetConstructor widgetBuilder = AFSubFormFieldWidget.new;

  @override
  String? validator([Object? object]) {
    sendForceErrorEvent();

    if (!form.isComplete()) {
      return form.getFirstError();
    }

    return super.validator(object);
  }

  @override
  Map get value => form.toMap();

  @override
  Map? parser(T unparsedValue) {
    return value;
  }
}

class AFMultipleSubFormField<T extends TemplateForm>
    extends Field<List<Map<String, dynamic>>> with WithForceErrorStream {
  AFMultipleSubFormField({
    required String id,
    required String name,
    required this.formBuilder,
    required this.forms,
    List<Validator<List<Map<String, dynamic>>>> validators = const [],
  }) : super(
          id: id,
          name: name,
          validators: validators,
        );

  final T Function() formBuilder;
  final List<T> forms;

  @override
  final FieldWidgetConstructor widgetBuilder = AFMultipleSubFormFieldWidget.new;

  @override
  String? validator([Object? object]) {
    sendForceErrorEvent();

    for (final form in forms) {
      if (!form.isComplete()) {
        return form.getFirstError();
      }
    }

    return super.validator(object);
  }

  @override
  List<Map<String, dynamic>>? get value =>
      [for (final form in forms) form.toMap()];

  @override
  List<Map<String, dynamic>>? parser(covariant Object? unparsedValue) {
    return value;
  }
}
