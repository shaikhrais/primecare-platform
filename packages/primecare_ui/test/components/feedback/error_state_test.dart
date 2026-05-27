import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Error Text renders correctly', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: Text(key: Key('error-msg'), 'Error occurred'),
        ),
      ),
    );
    expect(find.byKey(const Key('error-msg')), findsOneWidget);
  });
}