import 'package:primecare_ui/primecare_ui.dart';

void main() {
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

  if (violations == 0) {
    print('SUCCESS: All screens are compliant with Auditor Blueprints.');
  } else {
    print('ACTION REQUIRED: Resolve structural drift in $violations screens.');
  }
}
