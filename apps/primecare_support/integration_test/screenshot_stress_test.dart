// Governance - Category: test | Purpose: ------------------------------------------------------------- CUSTOM INTEGRATION TEST LOGIC GOES HERE ---------------...
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:flutter_core/testing/governance_stress_tester.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:primecare_support/main.dart' as app_main;
import 'package:primecare_support/core/routing/support_routes.dart' as app_main_routes;

void main() {
  final binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  
  final plan = GovernanceTestPlan(
    application: app_main_routes.SupportApplication(),
    appName: 'primecare_support',
    appBuilder: (overrides) {
      final allOverrides = [...overrides];
      allOverrides.add(platformApplicationProvider.overrideWithValue(app_main_routes.SupportApplication()));
      return ProviderScope(
        overrides: allOverrides.cast(),
        child: const app_main.PrimeCareSupportApp(),
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
