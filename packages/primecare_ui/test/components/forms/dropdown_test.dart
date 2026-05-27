import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Dropdown renders correctly', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: DropdownButton<String>(
            key: const Key('dropdown-field'),
            value: 'A',
            items: const [DropdownMenuItem(value: 'A', child: Text('Option A'))],
            onChanged: (_) {},
          ),
        ),
      ),
    );
    expect(find.byKey(const Key('dropdown-field')), findsOneWidget);
  });
}