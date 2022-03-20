const Map<String, dynamic> jsonSchema = {
  '\$schema': 'https://json-schema.org/draft/2020-12/schema',
  'title': 'Vieux fromages',
  '\$id': '',
  'description': 'Description',
  'type': 'object',
  'properties': {
    'Age (année)': {
      'type': 'integer',
      'default': 2001,
      'examples': [2001]
    },
    'Ca': {'type': 'number', 'examples': null},
    'Type': {
      'type': 'string',
      'default': 'Molle',
      'enum': ['Molle', 'Cremeux', 'Dure', 'Rapé']
    },
    'Type de lait': {
      'type': 'string',
      'default': 'Bufflone',
      'examples': ['Bufflone', 'Vache']
    },
    'Provenance': {'type': 'string', 'examples': []},
    'Affinage': {'type': 'string', 'examples': []},
    'Bio': {'type': 'boolean', 'enum': []},
    'Conservation': {
      'type': 'string',
      'default': '1 semaine frigo',
      'examples': ['1 semaine frigo']
    },
    'name': {'type': 'string'}
  },
  'required': ['Ca']
};
