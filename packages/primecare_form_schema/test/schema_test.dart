import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:primecare_form_schema/primecare_form_schema.dart';
void main() {
  testWidgets('renders schema title, field and save control', (tester) async {
    final schema = FormSchema<void>(title: 'Fixture', fields: [TextFieldSchema(id: 'name', label: 'Name')]);
    await tester.pumpWidget(MaterialApp(home: Scaffold(body: SchemaFormEngine<void>(schema: schema, onSave: (_) {}))));
    expect(find.text('Fixture'), findsOneWidget);
    expect(find.text('Name'), findsOneWidget);
    expect(find.text('Save'), findsOneWidget);
  });
}
