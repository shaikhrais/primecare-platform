// ignore_for_file: avoid_print
import 'package:flutter_test/flutter_test.dart';
import 'package:primecare_ui/primecare_ui.dart';

void main() {
  test('Governance Audit Report', () {
    ScreenRegistry.bootstrap();
    final results = AutomatedAuditEngine.runAudits();
    final score = AutomatedAuditEngine.calculateHealthScore();

    print('\n--- AUDIT FAILURES ---\n');
    for (final item in results.where((r) => !r.isPass)) {
      print('FAILED: ${item.check} - ${item.result}: ${item.meaning}');
    }
    print('\n--- END REPORT ---\n');
    print('Final Health Score: $score%');
  });
}
