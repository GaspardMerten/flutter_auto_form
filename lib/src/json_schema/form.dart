import 'package:flutter/material.dart';
import 'package:flutter_auto_form/flutter_auto_form.dart';
import 'package:flutter_auto_form/src/json_schema/json_schema.dart';
import 'package:flutter_auto_form/src/models/validator/validator.dart';

class JsonSchemaForm extends TemplateForm {
  JsonSchemaForm(this.fields);

  factory JsonSchemaForm.fromJson(Map<String, dynamic> json) {
    final JsonSchema schema = JsonSchema.fromJson(json);

    final List<Field<Object>> fields = [];

    for (final JsonSchemaProperty element in schema.properties) {
      final List<Validator<Object>> validators = [];

      switch (element.type) {
        case JsonSchemaType.string:
          fields.add(AFTextField(
            id: element.id,
            name: element.name,
            validators: validators,
            type: AFTextFieldType.TEXT,
          ));
          break;
        case JsonSchemaType.number:
          fields.add(AFNumberField(
            id: element.id,
            name: element.name,
            validators: [],
          ));
          break;
        case JsonSchemaType.boolean:
          fields.add(AFBooleanField(
            id: element.id,
            name: element.name,
            validators: [],
          ));
          break;
        default:
          debugPrint(
              '[Flutter Auto Form]: ${element.type} is not yet implemented.');
      }
    }

    return JsonSchemaForm(fields);
  }

  @override
  final List<Field<Object>> fields;
}
