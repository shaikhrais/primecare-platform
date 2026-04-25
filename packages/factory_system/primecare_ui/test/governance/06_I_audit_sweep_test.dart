import 'package:flutter_test/flutter_test.dart';
import 'package:primecare_ui/primecare_ui.dart';

void main() {
  test('Governance Audit Sweep', () {
    // 1. Initialize Registry
    ScreenRegistry.bootstrap();

    // 2. Perform Audit
    final reports = ScreenRegistry.auditRegistry();

    print('--- PRIMECARE GOVERNANCE AUDIT SWEEP ---');
    int total = reports.length;
    int healthy = reports.where((r) => r.isHealthy).length;
    int violations = total - healthy;

    print('Total Screens Audited: $total');
    print('Healthy Screens: $healthy');
    print('Violations Detected: $violations');
    print('----------------------------------------');

    for (final report in reports) {
      if (!report.isHealthy) {
        print('[FAILURE] ${report.route}');
        print('  Issues: ${report.message}');
        print('  Labels: ${report.componentLabels}');
        if (report.compliance != null) {
          print('  Blueprint Missing: ${report.compliance!.missingLabels}');
        }
        print('');
      }
    }

    expect(
      violations,
      0,
      reason: 'Found $violations structural compliance violations.',
    );
  });
}
