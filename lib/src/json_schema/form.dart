import 'package:flutter/material.dart';
import 'package:flutter_auto_form/src/json_schema/json_schema.dart';
import 'package:flutter_auto_form/src/models/field/field.dart';
import 'package:flutter_auto_form/src/models/form.dart';
import 'package:flutter_auto_form/src/models/validators/validator.dart';

class JsonSchemaForm extends TemplateForm {
  JsonSchemaForm(this.fields);

  factory JsonSchemaForm.fromJson(Map<String, dynamic> json) {
    final JsonSchema schema = JsonSchema.fromJson(json);

    final List<Field<Object>> fields = [];

    for (final JsonSchemaProperty element in schema.properties) {
      if (element.enumValues.isNotEmpty) {
        fields.add(AFSelectField(
          id: element.id,
          name: element.name,
          validators:
              buildValidators<List>(element, schema.isRequired(element)),
          values: element.enumValues,
          textBuilder: (e) => e.toString(),
          value: element.defaultValue ?? element.enumValues.first,
        ));
      } else {
        switch (element.type) {
          case JsonSchemaType.string:
            fields.add(AFTextField(
              id: element.id,
              name: element.name,
              validators:
                  buildValidators<String>(element, schema.isRequired(element)),
              value: element.defaultValue,
              type: AFTextFieldType.TEXT,
            ));
            break;
          case JsonSchemaType.number:
            final validators = buildValidators<num>(
              element,
              schema.isRequired(element),
            );

            final minimum = element.getOption('min');
            if (minimum != null) {
              validators.add(MinValueValidator(
                'The value should be greater or equal to $minimum',
                minimum,
              ));
            }

            final maximum = element.getOption('max');

            if (maximum != null) {
              validators.add(MaxValueValidator(
                'The value should be smaller or equal to $maximum',
                minimum,
              ));
            }

            fields.add(AFNumberField(
              id: element.id,
              name: element.name,
              value: element.defaultValue as num?,
              validators: validators,
            ));
            break;
          case JsonSchemaType.integer:
            final validators = buildValidators<num>(
              element,
              schema.isRequired(element),
            );

            final minimum = element.getOption('min');
            if (minimum != null) {
              validators.add(MinValueValidator(
                'The value should be greater or equal to $minimum',
                minimum,
              ));
            }

            final maximum = element.getOption('max');

            if (maximum != null) {
              validators.add(MaxValueValidator(
                'The value should be smaller or equal to $maximum',
                maximum,
              ));
            }

            fields.add(
              AFNumberField(
                id: element.id,
                name: element.name,
                value: element.defaultValue as int?,
                validators: [
                  ...validators,
                  IsIntegerValidator('Please enter a valid integer')
                ],
              ),
            );
            break;
          case JsonSchemaType.boolean:
            fields.add(AFBooleanField(
              id: element.id,
              name: element.name,
              value: element.defaultValue as bool? ?? false,
              validators:
                  buildValidators<bool>(element, schema.isRequired(element)),
            ));
            break;
          default:
            debugPrint(
                '[Flutter Auto Form]: ${element.type} is not yet implemented.');
        }
      }
    }

    return JsonSchemaForm(fields);
  }

  @override
  final List<Field<Object>> fields;
}

List<Validator<T>> buildValidators<T>(
    JsonSchemaProperty element, bool required) {
  final List<Validator<T>> validators = [];

  if (required) {
    validators.add(const NotNullValidator('This field cannot be null'));
  }

  return validators;
}
