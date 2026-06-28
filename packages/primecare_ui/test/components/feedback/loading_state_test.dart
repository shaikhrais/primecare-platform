import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Circular progress indicator renders correctly', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: CircularProgressIndicator(key: Key('loading-indicator')),
        ),
      ),
    );
    expect(find.byKey(const Key('loading-indicator')), findsOneWidget);
  });
}
