import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Primary Button renders correctly', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: ElevatedButton(key: const Key('primary_button_test_elevatedbutton_button_1'), key: const Key('primary-btn'), onPressed: () {}, child: const Text('Save')),
        ),
      ),
    );
    expect(find.byKey(const Key('primary-btn')), findsOneWidget);
  });
}