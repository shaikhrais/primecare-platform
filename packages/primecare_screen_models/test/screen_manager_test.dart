import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:primecare_screen_models/primecare_screen_models.dart';

void main() {
  test('registrations retain explicit features', () {
    final manager = ScreenManager([const ManagedScreenRegistration(id: 'one')]);
    expect(manager.lookup('one'), isNotNull);
    expect(manager.lookup('missing'), isNull);
  });
  testWidgets('registered screen uses the shared presentation boundary', (tester) async {
    await tester.pumpWidget(MaterialApp(home: AppShellBoundary(
      child: ManagedScreenBoundary(
        manager: ScreenManager([const ManagedScreenRegistration(id: 'one')]),
        screenId: 'one',
        builder: (_) => const Text('Registered'),
      ),
    )));
    expect(find.text('Registered'), findsOneWidget);
  });
}
