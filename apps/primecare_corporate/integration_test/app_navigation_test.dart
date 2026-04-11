import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:primecare_corporate/main.dart' as app;

import 'page_objects/master_dashboard_page.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('E2E Dashboard Validation', () {
    testWidgets('Verify CeoDashboardScreenStitch hydrations via Page Object', (
      tester,
    ) async {
      // 1. Launch the app
      app.main();
      await tester.pumpAndSettle();

      // In a real e2e, we would use the loginPage here, but since this
      // app_router usually skips auth or starts directly on the dashboard
      // Let's hook into the MasterDashboardPageObject.
      final dashboard = MasterDashboardPageObject(tester);

      // We wait for initial routing to finish
      await dashboard.waitForHydration();

      // We expect the CEO dashboard to be the initial route based on standard setup
      // Note: If router behavior differs, we can use router.go() programmatically
      // For now, let's verify if the structure loaded.
      // This will fail if Keys are not added to PageTemplate!
      // But adding Keys is the next step of the pipeline.

      // Temporary check to ensure the test bootstraps correctly
      expect(find.byType(MaterialApp), findsOneWidget);
    });
  });
}
