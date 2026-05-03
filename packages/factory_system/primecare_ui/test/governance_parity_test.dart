import 'package:flutter_test/flutter_test.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'package:primecare_ui/src/governance_bootstrapper.dart';

void main() {
  test('Governance Blueprint Parity Audit', () {
    GovernanceBootstrapper.bootstrap();
    
    final auditResults = GovernanceRegistry.performBlueprintAudit();
    final compliantCount = auditResults.where((r) => r.isCompliant).length;
    final parityScore = auditResults.isEmpty ? 100.0 : (compliantCount / auditResults.length) * 100;
    final mismatches = auditResults.where((r) => !r.isCompliant).toList();
    
    print('--- Governance Blueprint Audit Results ---');
    print('Parity Score: ${parityScore.toStringAsFixed(1)}%');
    print('Total Mismatches: ${mismatches.length}');
    
    for (final mismatch in mismatches) {
      print('[MISMATCH] ${mismatch.route}: Missing ${mismatch.missingLabels.join(", ")}');
    }
    
    expect(parityScore, greaterThanOrEqualTo(90.0), reason: 'Architectural parity must be high.');
  });
}
