$apps = @(
    @{ name = "primecare_business_development"; class = "PrimeCareBusinessDevelopmentApp"; applicationClass = "BusinessDevelopmentApplication()"; routeImport = "import 'package:primecare_business_development/core/routing/business_development_routes.dart' as app_main_routes;" },
    @{ name = "primecare_client"; class = "PrimeCareClientApp"; applicationClass = "ClientApplication()"; routeImport = "import 'package:primecare_client/core/routing/client_routes.dart' as app_main_routes;" },
    @{ name = "primecare_clinic"; class = "PrimeCareClinicApp"; applicationClass = "ClinicApplication()"; routeImport = "import 'package:primecare_clinic/core/routing/clinic_routes.dart' as app_main_routes;" },
    @{ name = "primecare_corporate"; class = "PrimeCareCorporateApp"; applicationClass = "CorporateApplication()"; routeImport = "import 'package:primecare_corporate/core/routing/corporate_routes.dart' as app_main_routes;" },
    @{ name = "primecare_franchise"; class = "PrimeCareFranchiseApp"; applicationClass = "FranchiseApplication()"; routeImport = "import 'package:primecare_franchise/core/routing/franchise_routes.dart' as app_main_routes;" },
    @{ name = "primecare_marketing"; class = "PrimeCareMarketingApp"; applicationClass = "MarketingApplication()"; routeImport = "import 'package:primecare_marketing/core/routing/marketing_routes.dart' as app_main_routes;" },
    @{ name = "primecare_support"; class = "PrimeCareSupportApp"; applicationClass = "SupportApplication()"; routeImport = "import 'package:primecare_support/core/routing/support_routes.dart' as app_main_routes;" }
)

foreach ($app in $apps) {
    $appName = $app.name
    $className = $app.class
    $applicationClass = $app.applicationClass
    $routeImport = $app.routeImport
    $override = "platformApplicationProvider.overrideWithValue(app_main_routes.$applicationClass)"

    Write-Host "Creating test for $appName..."
    $testDir = "apps\$appName\integration_test"
    if (!(Test-Path $testDir)) {
        New-Item -ItemType Directory -Force -Path $testDir | Out-Null
    }

    $testContent = @"
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_core/testing/governance_stress_tester.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:$appName/main.dart' as app_main;
$routeImport

void main() {
  final binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  
  final plan = GovernanceTestPlan(
    application: app_main_routes.$applicationClass,
    appName: '$appName',
    appBuilder: (overrides) {
      final allOverrides = [...overrides];
      allOverrides.add($override);
      return ProviderScope(
        overrides: allOverrides.cast(),
        child: const app_main.$className(),
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
"@

    $filePath = "$testDir\screenshot_stress_test.dart"
    Set-Content -Path $filePath -Value $testContent
    Write-Host "Created $filePath"
}

Write-Host "All tests created! You can now run them using 'flutter test apps/<app_name>/integration_test/screenshot_stress_test.dart -d windows'"
