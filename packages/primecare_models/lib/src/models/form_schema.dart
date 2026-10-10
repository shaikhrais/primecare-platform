/// Represents a generic field in the Schema
abstract class SchemaField {
  final String id;
  final String label;

  SchemaField({required this.id, required this.label});
}

class TextFieldSchema extends SchemaField {
  final String? placeholder;

  TextFieldSchema({required super.id, required super.label, this.placeholder});
}

/// Generic Form Schema Definition
class FormSchema<T> {
  final String title;
  final List<SchemaField> fields;

  FormSchema({required this.title, required this.fields});
}
