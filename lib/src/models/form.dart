import 'package:flutter_auto_form/src/models/field/field.dart';

/// An abstract class that makes it easy to create form with a strong validation
/// system.
///
/// Use the toMap() method to retrieve all the fields values.
///
/// See [Field] and [Validator] for more information.
abstract class TemplateForm {
  TemplateForm() {
    final Set<String> ids = {};

    for (final Field field in fields) {
      if (ids.contains(field.id)) {
        throw Exception(
            'Ids are not unique for form $runtimeType (duplicated id: ${field.id})');
      }
      ids.add(field.id);
    }
  }

  List<Field<Object>> get fields;

  bool isComplete() {
    for (final Field field in fields) {
      if (field.validator(field.value) != null) {
        return false;
      }
    }

    return true;
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
    return fields.singleWhere((e) => e.id == id, orElse: null).value as T?;
  }

  dynamic set(String id, dynamic value) {
    return fields.singleWhere((e) => e.id == id, orElse: null).value = value;
  }

  Map<String, Object?> toMap() => Map.fromIterable(
        fields,
        key: (a) => a.id,
        value: (field) => field.value,
      );
}
