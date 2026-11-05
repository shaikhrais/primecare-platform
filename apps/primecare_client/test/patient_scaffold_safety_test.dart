import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:primecare_client/features/patient/screens/patient_dashboard_screen.dart';
import 'package:primecare_client/features/patient/screens/patient_profile_screen.dart';

void main() {
  for (final example in <(Widget, String)>[
    (const PatientDashboardScreen(), 'The patient dashboard is not available yet.'),
    (const PatientProfileScreen(), 'The patient profile is not available yet.'),
  ]) {
    testWidgets('scaffold presents an honest unavailable state: ${example.$2}', (tester) async {
      await tester.pumpWidget(ProviderScope(child: MaterialApp(
        home: AppShellBoundary(child: example.$1),
      )));
      await tester.pumpAndSettle();
      expect(find.text(example.$2), findsOneWidget);
      expect(find.textContaining('fully implemented'), findsNothing);
      expect(find.byIcon(Icons.check_circle_outline), findsNothing);
      expect(tester.takeException(), isNull);
    });
  }
}
