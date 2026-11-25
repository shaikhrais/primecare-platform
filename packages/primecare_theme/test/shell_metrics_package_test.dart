import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:primecare_theme/primecare_theme.dart';

void main() {
  test('canonical shell dimensions retain reference breakpoints', () {
    expect(PrimeShellMetrics.desktopBreakpoint, 960);
    expect(PrimeShellMetrics.horizontalDesktopBreakpoint, 1280);
    expect(PrimeShellMetrics.mobileDrawerWidth, 280);
    expect(PrimeShellMetrics.foldedNavigationWidth, 48);
    expect(PrimeThemeCenterStyle.panelWidth, 380);
    expect(PrimeThemeCenterStyle.inset(599), 16);
    expect(PrimeThemeCenterStyle.inset(600), 24);
  });
  testWidgets('toolbar account frame wraps the original child', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: PrimeToolbarAccountFrame(child: Text('Account'))));
    expect(find.text('Account'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}
