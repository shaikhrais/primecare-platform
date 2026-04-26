import 'package:flutter_core/00_B_flutter_core.dart';
import 'package:primecare_ui/src/registry/02_I_governance_bootstrapper.dart';

void main() {
  print('--- PrimeCare Architectural Integrity Audit ---');
  
  // 1. Bootstrap the registry with UI intents
  print('Bootstrapping Registry...');
  GovernanceBootstrapper.bootstrap();
  
  // 2. Perform Domain Audit
  print('Performing Domain Audit...');
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
  
  // 3. Health Sweep (Requires a mock ref if we were checking providers, but let's see if we can do basic check)
  // final health = GovernanceRegistry.performHealthSweep(null);
  
  print('\n--- Audit Complete ---');
}
