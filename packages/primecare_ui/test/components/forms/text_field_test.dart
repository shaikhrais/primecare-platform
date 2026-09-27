import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Text Field renders correctly', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: TextFormField(key: const Key('text-field'), initialValue: 'Test'),
        ),
      ),
    );
    expect(find.byKey(const Key('text-field')), findsOneWidget);
  });
}
