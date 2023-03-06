import 'package:flutter_auto_form/src/models/field/field.dart';

/// An abstract class that makes it easy to create form with a strong validation
/// system.
///
/// Use the toMap() method to retrieve all the fields values.
///
/// See [Field] and [Validator] for more information.
abstract class TemplateForm {
  List<Field> get fields;

  bool isComplete() {
    // It is important to not directly return false in the for boucle because
    // in the case a subform is present in the fields, it needs this call
    // to display error.
    bool isComplete = true;

    for (final Field field in fields) {
      if (field.validator(field.value) != null) {
        isComplete = false;
      }
    }

    return isComplete;
  }

  String? getFirstError() {
    for (final Field field in fields) {
      final String? error = field.validator(field.value);
      if (error != null) {
        return error;
      }
    }

    return null;
  }

  T? get<T>(String id) {
    return fields.singleWhere((e) => e.id == id).value as T?;
  }

  dynamic set(String id, dynamic value) {
    return fields.singleWhere((e) => e.id == id).value = value;
  }

  Map<String, Object?> toMap() {
    return { for (var e in fields) e.id : e.value };
  }
}
