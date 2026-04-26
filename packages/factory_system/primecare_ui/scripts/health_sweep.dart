import 'package:primecare_ui/primecare_ui.dart';
import 'package:test/test.dart';

/// PrimeCare Platform Health Sweep
/// This script validates the integrity of the ScreenRegistry and its associated intents.
void main() {
  test('Platform Health Sweep: Registry Integrity', () async {
    // ProviderContainer is needed if any registry check depends on providers
    final container = ProviderContainer();

    print('=========================================');
    print('PRIMECARE_GOVERNANCE: Initiating Platform Health Sweep...');
    print('=========================================');

    try {
      // Perform static audit of the registry
      final auditReports = ScreenRegistry.auditRegistry();

      int healthyCount = 0;
      for (final report in auditReports) {
        if (report.isHealthy) {
          healthyCount++;
          print(' [OK] ${report.route}');
        } else {
          print(' [FAIL] ${report.route}: ${report.message}');
        }
      }

      print('=========================================');
      print(
        'Sweep Complete: $healthyCount/${auditReports.length} intents are healthy.',
      );
      print('=========================================');

      expect(
        healthyCount,
        equals(auditReports.length),
        reason:
            'Registry integrity compromised. Fix the failures before deployment.',
      );
    } finally {
      container.dispose();
    }
  });
}
