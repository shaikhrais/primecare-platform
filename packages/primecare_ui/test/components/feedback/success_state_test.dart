import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Success Text renders correctly', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: Text(key: Key('success-msg'), 'Success operation'),
        ),
      ),
    );
    expect(find.byKey(const Key('success-msg')), findsOneWidget);
  });
}