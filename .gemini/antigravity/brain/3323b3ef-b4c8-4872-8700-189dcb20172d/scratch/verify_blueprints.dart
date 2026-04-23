import 'package:flutter_core/00_B_flutter_core.dart';
import 'package:primecare_ui/src/registry/02_I_governance_bootstrapper.dart';
import 'package:primecare_ui/src/registry/04_I_platform_governance_audit.dart';

void main() {
  print('--- AUDITOR BLUEPRINT VERIFICATION ---');
  
  // 1. Bootstrap the system (seeds blueprints and registers intents)
  GovernanceBootstrapper.bootstrap();
  
  print('Blueprints Registered: ${BlueprintRegistry.getAll().length}');
  for (var bp in BlueprintRegistry.getAll()) {
    print(' - ${bp.route}: ${bp.requiredComponents.length} requirements');
  }
  
  // 2. Perform Blueprint Audit
  final auditResults = GovernanceRegistry.performBlueprintAudit();
  
  print('\n--- Audit Results ---');
  for (var result in auditResults) {
    print(result.toString());
  }
  
  print('\n--- System-Wide Audit Report ---');
  // Mocking 'ref' for now as we don't need riverpod for structural audit
  final globalAudit = PlatformGovernanceAudit.performAudit(null);
  print(globalAudit.toString());
}
