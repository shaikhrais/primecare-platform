import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:primecare_ui/src/screens/psw/psw_dashboard/sections/psw_dashboard_actions_section.dart';

void main() {
  testWidgets('unconnected PSW actions cannot imply a successful write', (
    tester,
  ) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(body: PswDashboardActionsSection()),
      ),
    );

    const ids = [
      'pswdashboard-btn-emergency',
      'psw-start-shift-btn',
      'psw-view-vitals-btn',
      'psw-report-incident-btn',
    ];
    for (final id in ids) {
      final action = find.byWidgetPredicate(
        (widget) => widget is ElevatedButton && widget.key == ValueKey(id),
      );
      expect(action, findsOneWidget);
      expect(tester.widget<ElevatedButton>(action).onPressed, isNull);
      await tester.tap(action, warnIfMissed: false);
      await tester.pump();
      expect(find.byType(AlertDialog), findsNothing);
    }
  });
}
