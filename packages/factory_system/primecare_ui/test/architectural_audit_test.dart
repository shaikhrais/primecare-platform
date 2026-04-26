import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_core/00_B_flutter_core.dart';
import 'package:primecare_ui/src/registry/02_I_governance_bootstrapper.dart';

void main() {
  test('Architectural Integrity Audit - Platform Role Coverage', () {
    print('--- PrimeCare Architectural Integrity Audit ---');
    
    // 1. Bootstrap the registry with UI intents
    GovernanceBootstrapper.bootstrap();
    
    // 2. Perform Domain Audit
    final audit = GovernanceRegistry.performDomainAudit();
    
    print('\nRESULTS:');
    print('Integrity Score: ${audit.integrityScore.toStringAsFixed(1)}%');
    print('Total Roles Scanned: ${audit.totalRoles}');
    print('Realized Roles: ${audit.realized.length}');
    print('Pending Roles: ${audit.pending.length}');
    
    if (audit.pending.isNotEmpty) {
      print('\nMISSING ROLE IMPLEMENTATIONS:');
      for (final role in audit.pending) {
        print('  - ${role.displayName} (${role.nameSnake})');
      }
    }
    
    expect(audit.integrityScore, greaterThanOrEqualTo(90.0), reason: 'Integrity score should be at least 90%');
  });
}
