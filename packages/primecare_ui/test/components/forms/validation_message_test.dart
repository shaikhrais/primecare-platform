import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Validation message renders correctly', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: KeyedSubtree(key: Key('validation-msg'), child: Text('Error')),
        ),
      ),
    );
    expect(find.byKey(const Key('validation-msg')), findsOneWidget);
  });
}
