abstract class JsonSchemaObject {
  List<JsonSchemaProperty> get properties;

  List<String> get required;
}

class JsonSchema implements JsonSchemaObject {
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
      properties.add(JsonSchemaProperty.fromJson(id, json));
    });

    return JsonSchema(
      schema: json['\$schema'],
      id: json['\$id'],
      title: json['title'],
      description: json['description'],
      properties: properties,
      required: json['required'],
    );
  }

  final String schema;
  final String id;
  final String title;
  final String description;

  @override
  final List<JsonSchemaProperty> properties;

  @override
  final List<String> required;
}

final RegExp exp = RegExp(r'(?<=[a-z])[A-Z]');

class JsonSchemaProperty implements JsonSchemaObject {
  JsonSchemaProperty({
    required this.id,
    required this.description,
    required this.type,
    this.options = const [],
    this.properties = const [],
    this.required = const [],
  });

  factory JsonSchemaProperty.fromJson(String id, Map<String, dynamic> json) {
    final String type = json['type'];
    final String? description = json['description'];

    final List<PropertyOption> options = [];

    final List<JsonSchemaProperty> properties = [];

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
        properties: properties,
        required: json['required'] ?? []);
  }

  final String id;
  final String? description;
  final JsonSchemaType type;
  final List<PropertyOption> options;
  @override
  final List<JsonSchemaProperty> properties;
  @override
  final List<String> required;

  String get name {
    return id.replaceAllMapped(exp, (Match m) => ' ' + (m.group(0) ?? ''));
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

enum JsonSchemaType { string, number, object, array, boolean, undefined }
