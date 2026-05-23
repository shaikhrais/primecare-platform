// Governance - Category: test | Purpose: ------------------------------------------------------------- CUSTOM INTEGRATION TEST LOGIC GOES HERE ---------------...
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:flutter_core/testing/governance_stress_tester.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:primecare_client/main.dart' as app_main;
import 'package:primecare_client/core/routing/client_routes.dart' as app_main_routes;

void main() {
  final binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  
  final plan = GovernanceTestPlan(
    application: app_main_routes.ClientApplication(),
    appName: 'primecare_client',
    appBuilder: (overrides) {
      final allOverrides = [...overrides];
      allOverrides.add(platformApplicationProvider.overrideWithValue(app_main_routes.ClientApplication()));
      return ProviderScope(
        overrides: allOverrides.cast(),
        child: const app_main.PrimeCareClientApp(),
      );
    },
    customTestSteps: (WidgetTester tester, PlatformRole activeRole) async {
      // -------------------------------------------------------------
      // CUSTOM INTEGRATION TEST LOGIC GOES HERE
      // -------------------------------------------------------------
    },
  );

  GovernanceEngine(binding).execute(plan);
}
