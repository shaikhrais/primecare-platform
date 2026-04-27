// Layer: 01_INFRASTRUCTURE
import 'package:flutter/material.dart';

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

/// The SchemaFormEngine parses a FormSchema and dynamically returns UI.
class SchemaFormEngine<T> extends StatelessWidget {
  final FormSchema<T> schema;
  final T Function(Map<String, dynamic> data) onSave;

  const SchemaFormEngine({
    super.key,
    required this.schema,
    required this.onSave,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(schema.title, style: Theme.of(context).textTheme.headlineSmall),
        const SizedBox(height: 16),
        ...schema.fields.map((field) {
          if (field is TextFieldSchema) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: TextFormField(
                decoration: InputDecoration(
                  labelText: field.label,
                  hintText: field.placeholder,
                  border: const OutlineInputBorder(),
                ),
              ),
            );
          }
          return const SizedBox.shrink();
        }),
        ElevatedButton(
          onPressed: () {
            onSave({});
          },
          child: const Text('Save'),
        ),
      ],
    );
  }
}
