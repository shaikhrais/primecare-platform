import 'package:flutter_test/flutter_test.dart';
import 'package:primecare_ui/src/engine/automated_audit_engine.dart';
import 'package:primecare_ui/src/governance_bootstrapper.dart';


void main() {
  test('Governance Health Audit', () {
    GovernanceBootstrapper.bootstrap();
    final score = AutomatedAuditEngine.calculateHealthScore();
    expect(score, equals(100.0), reason: 'Governance Health Score must be 100%');
  });
}
