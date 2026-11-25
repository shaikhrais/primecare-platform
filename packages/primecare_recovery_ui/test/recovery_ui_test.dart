import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:primecare_recovery_ui/primecare_recovery_ui.dart';

void main() {
  testWidgets('offline retry is optional and calls the supplied callback', (tester) async {
    var retries = 0;
    await tester.pumpWidget(const MaterialApp(home: Scaffold(body: SystemOfflinePanel())));
    expect(find.text('System Unavailable'), findsOneWidget);
    expect(find.text('Retry'), findsNothing);
    await tester.pumpWidget(MaterialApp(home: Scaffold(body: SystemOfflinePanel(onReset: () => retries++))));
    await tester.tap(find.text('Retry'));
    expect(retries, 1);
    expect(tester.takeException(), isNull);
  });
  testWidgets('recovery action is reachable on a narrow viewport', (tester) async {
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    var resets = 0;
    await tester.pumpWidget(MaterialApp(home: SystemRecoveryMode(
      error: StateError('Synthetic failure'), onAttemptReset: () => resets++)));
    await tester.ensureVisible(find.text('Attempt Interface Reset'));
    await tester.tap(find.text('Attempt Interface Reset'));
    expect(resets, 1);
    expect(tester.takeException(), isNull);
  });
}
