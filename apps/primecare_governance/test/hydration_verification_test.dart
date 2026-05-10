import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:primecare_governance/core/governance/governance_provider.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  test('Hydration Verification - CompletionPercent and Office propagation', () async {
    // 1. Setup - Path to blueprints.yaml
    final projectRoot = 'c:\\Users\\Admin2\\Documents\\GitHub\\primecare-platform';
    
    // We need to make sure the GovernanceNotifier uses this path.
    // In governance_provider.dart, it uses Directory.current.path.
    // If we run the test from the root, it works.
    // If we run from apps/primecare_governance, we might need to adjust.
    
    final container = ProviderContainer();
    final notifier = container.read(governanceProvider.notifier);
    
    // 2. Run Hydration
    // We expect this to read .agents/governance/blueprints.yaml relative to current dir.
    // If running from apps/primecare_governance, we need to be careful.
    
    PrimeLogger.info('Running hydrateRegistries...');
    await notifier.hydrateRegistries();
    
    // 3. Verify specifically the new screen we added to blueprints.yaml
    // Screen ID in YAML: clinical.clinical_director.reports
    // Normalized ID: SCREEN_CLINICAL_DIRECTOR_REPORTS
    
    final reportsScreen = PlatformScreenRegistry.getById('SCREEN_CLINICAL_DIRECTOR_REPORTS');
    
    expect(reportsScreen, isNotNull, reason: 'Hydration should have injected SCREEN_CLINICAL_DIRECTOR_REPORTS');
    
    PrimeLogger.info('Found hydrated screen: ${reportsScreen!.id}');
    PrimeLogger.info('Completion Percent: ${reportsScreen.completionPercent}%');
    PrimeLogger.info('Office: ${reportsScreen.office}');
    
    expect(reportsScreen.completionPercent, 45.0);
    expect(reportsScreen.office, 'Clinical Analytics');
    
    // 4. Verify other screens from blueprints.yaml (which were already in registry but skipped by hydrator)
    // Wait, since they were skipped, their completionPercent/office might still be default if they weren't set in CoreGovernanceRegistry.
    
    final pswDashboard = PlatformScreenRegistry.getById('SCREEN_PSW_DASHBOARD');
    expect(pswDashboard, isNotNull);
    PrimeLogger.info('PSW Dashboard Completion: ${pswDashboard!.completionPercent}%');
    PrimeLogger.info('PSW Dashboard Office: ${pswDashboard.office}');
    
    expect(pswDashboard.completionPercent, 92.0);
    expect(pswDashboard.office, 'Frontline Operations');
    
    PrimeLogger.info('SUCCESS: Hydration verification passed.');
  });
}
