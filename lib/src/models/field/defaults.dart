import 'package:flutter/material.dart';
import 'package:flutter_auto_form/flutter_auto_form.dart';
import 'package:flutter_auto_form/src/configuration/typedef.dart';
import 'package:flutter_auto_form/src/models/field/field_context.dart';
import 'package:flutter_auto_form/src/models/validators/validator.dart';
import 'package:flutter_auto_form/src/widgets/fields/fields.dart';
import 'package:flutter_auto_form/src/widgets/fields/form_field.dart';
import 'package:flutter_auto_form/src/widgets/fields/search_field.dart';

import 'field.dart';

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
  final FieldWidgetConstructor widgetBuilder = SelectFieldWidget.new;
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
  final FieldWidgetConstructor widgetBuilder = BooleanFieldWidget.new;
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
  final FieldWidgetConstructor widgetBuilder = SearchModelFieldWidget.new;
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
  final FieldWidgetConstructor widgetBuilder = SearchMultipleModelsField.new;
}

class AFFormFieldController extends ChangeNotifier {
  void validate() {
    notifyListeners();
  }
}

class AFFormField<T extends TemplateForm> extends Field<Map> {
  AFFormField(
    String id,
    String name,
    List<Validator<Object?>> validators,
    this.form,
  ) : super(id, name, validators);

  final T form;

  final AFFormFieldController controller = AFFormFieldController();

  @override
  Map? get value => form.toMap();

  @override
  String? validator([Object? _]) {
    controller.validate();
    return form.getFirstError();
  }

  @override
  Map? parser(covariant Object? unparsedValue) => form.toMap();

  @override
  FieldWidgetConstructor get widgetBuilder {
    return ({
      Key? key,
      required FieldContext fieldContext,
    }) {
      print('XXX $name ${fieldContext.field.name}');
      return FormFieldWidget(
        fieldContext: fieldContext,
        key: key,
        controller: controller,
      );
    };
  }
}

class AFMultipleFormField<T extends TemplateForm> extends Field<List<Map>> {
  AFMultipleFormField(
    String id,
    String name,
    List<Validator<Object?>> validators,
    this.formBuilder, {
    this.maxFormCount,
    this.initialFormCount = 1,
  }) : super(id, name, validators);

  final int? maxFormCount;
  final int initialFormCount;

  final T Function() formBuilder;

  late final List<T> forms = [];

  final AFFormFieldController controller = AFFormFieldController();

  @override
  List<Map> get value => forms.map((e) => e.toMap()).toList();

  @override
  String? validator([Object? _]) {
    controller.validate();

    for (final T form in forms) {
      final error = form.getFirstError();
      if (error != null) {
        return error;
      }
    }

    return null;
  }

  @override
  List<Map>? parser(covariant Object? unparsedValue) => value;

  @override
  FieldWidgetConstructor get widgetBuilder {
    return ({
      Key? key,
      required FieldContext fieldContext,
    }) {
      print('yyy $name');
      return MultipleFormFieldWidget(
        fieldContext: fieldContext,
        key: key,
        controller: controller,
      );
    };
  }

  void addForm() => forms.add(formBuilder());

  void removeForm(form) => forms.remove(form);
}
