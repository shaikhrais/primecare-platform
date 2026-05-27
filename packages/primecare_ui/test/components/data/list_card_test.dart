import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('List Card renders correctly', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: Card(key: Key('list-card'), child: Text('Card')),
        ),
      ),
    );
    expect(find.byKey(const Key('list-card')), findsOneWidget);
  });
}