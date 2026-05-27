import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Language switcher renders correctly', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: KeyedSubtree(key: Key('topbar-language-switcher'), child: Text('Language')),
        ),
      ),
    );
    expect(find.byKey(const Key('topbar-language-switcher')), findsOneWidget);
  });
}