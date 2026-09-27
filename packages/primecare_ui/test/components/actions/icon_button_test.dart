import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Icon Button renders correctly', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: IconButton(key: const Key('icon-btn'), icon: const Icon(Icons.add), onPressed: () {}),
        ),
      ),
    );
    expect(find.byKey(const Key('icon-btn')), findsOneWidget);
  });
}
