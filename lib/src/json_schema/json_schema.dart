abstract class JsonSchemaObject {
  List<JsonSchemaProperty> get properties;
}

const Map<JsonSchemaType, Function> _typeToPropertyConstructor = {
  JsonSchemaType.object: JsonSchemaProperty<Map>.fromJson,
  JsonSchemaType.integer: JsonSchemaProperty<int>.fromJson,
  JsonSchemaType.number: JsonSchemaProperty<num>.fromJson,
  JsonSchemaType.array: JsonSchemaProperty<List>.fromJson,
  JsonSchemaType.boolean: JsonSchemaProperty<bool>.fromJson,
  JsonSchemaType.string: JsonSchemaProperty<String>.fromJson,
  JsonSchemaType.undefined: JsonSchemaProperty<Object>.fromJson,
};

class JsonSchema extends JsonSchemaObject {
  JsonSchema({
    required this.schema,
    required this.id,
    required this.title,
    required this.description,
    required this.properties,
    required this.required,
  });

  factory JsonSchema.fromJson(Map<String, dynamic> json) {
    final List<JsonSchemaProperty> properties = [];

    json['properties']?.forEach((id, json) {
      properties.add(
        _typeToPropertyConstructor[_parseType(json['type'])]!(id, json),
      );
    });

    return JsonSchema(
      schema: json['\$schema'],
      id: json['\$id'],
      title: json['title'],
      description: json['description'],
      properties: properties,
      required: json['required'].map<String>((e) => e.toString()).toList(),
    );
  }

  final String schema;
  final String id;
  final String title;
  final String description;

  @override
  final List<JsonSchemaProperty> properties;

  final List<String> required;

  bool isRequired(JsonSchemaProperty<Object> element) {
    return required.contains(element.id);
  }
}

final RegExp exp = RegExp(r'(?<=[a-z])[A-Z]');

class JsonSchemaProperty<T extends Object> extends JsonSchemaObject {
  JsonSchemaProperty({
    required this.id,
    required this.description,
    required this.type,
    this.defaultValue,
    this.options = const [],
    this.properties = const [],
    this.enumValues = const [],
    this.examples = const [],
  });

  factory JsonSchemaProperty.fromJson(String id, Map<String, dynamic> json) {
    final String type = json['type'];
    final String? description = json['description'];

    final List<PropertyOption> options = [];

    final List<JsonSchemaProperty> properties = [];

    final List<T> enumValues = [];

    if ((json['enum'] ?? []).isNotEmpty) {
      json['enum'].forEach(enumValues.add);
    }

    final List<T> examples = [];

    if ((json['examples'] ?? []).isNotEmpty) {
      json['examples'].forEach(examples.add);
    }

    json['properties']?.forEach((id, json) {
      if (id != 'type' && id != 'description') {
        properties.add(JsonSchemaProperty.fromJson(id, json));
      }
    });

    json.forEach((key, value) {
      options.add(PropertyOption(key, value));
    });

    return JsonSchemaProperty(
      id: id,
      description: description,
      type: _parseType(type),
      options: options,
      defaultValue: json['default'],
      properties: properties,
      enumValues: enumValues,
      examples: examples,
    );
  }

  final String id;
  final String? description;
  final JsonSchemaType type;
  final T? defaultValue;
  final List<T> examples;
  final List<T> enumValues;
  final List<PropertyOption> options;
  @override
  final List<JsonSchemaProperty> properties;

  String get name {
    return id.replaceAllMapped(exp, (Match m) => ' ' + (m.group(0) ?? ''));
  }

  dynamic getOption(String name) {
    final results = options.where(
      (element) => element.name == name,
    );

    if (results.isNotEmpty) {
      return results.first.value;
    }
  }
}

class PropertyOption {
  PropertyOption(this.name, this.value);

  final String name;
  final dynamic value;
}

JsonSchemaType _parseType(String type) {
  switch (type) {
    case 'string':
      return JsonSchemaType.string;
    case 'number':
      return JsonSchemaType.number;
    case 'integer':
      return JsonSchemaType.integer;
    case 'object':
      return JsonSchemaType.object;
    case 'array':
      return JsonSchemaType.array;
    case 'boolean':
      return JsonSchemaType.boolean;
    default:
      return JsonSchemaType.undefined;
  }
}

enum JsonSchemaType {
  string,
  integer,
  number,
  object,
  array,
  boolean,
  undefined
}
