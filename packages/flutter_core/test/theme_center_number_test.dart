import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_core/theme/prime_theme_center.dart';

void main() {
  testWidgets('external width updates clear stale errors and range changes revalidate', (tester) async {
    final changes = <int>[];
    Future<void> mount(int value, {int min = 960, int max = 1920}) => tester.pumpWidget(MaterialApp(
      home: Scaffold(body: PrimeSettingsNumber(label: 'Container Width (px)',
        value: value, min: min, max: max, onChanged: changes.add)),
    ));
    await mount(1280);
    await tester.enterText(find.byType(TextField), '0');
    await tester.pump();
    expect(find.text('960–1920'), findsOneWidget);
    expect(changes, isEmpty);
    await mount(1120);
    await tester.pumpAndSettle();
    expect(find.text('960–1920'), findsNothing);
    expect(tester.widget<TextField>(find.byType(TextField)).controller!.text, '1120');
    await tester.enterText(find.byType(TextField), '1800');
    await tester.pump();
    expect(changes, [1800]);
    await mount(1120, max: 1600);
    await tester.pumpAndSettle();
    expect(find.text('960–1600'), findsOneWidget);
    await mount(1120);
    await tester.pumpAndSettle();
    expect(find.text('960–1600'), findsNothing);
    expect(tester.takeException(), isNull);
  });
}
