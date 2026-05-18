import 'package:flutter_core/registry/governance_registry.dart';
import 'package:primecare_clinic/core/routing/clinic_routes.dart';

void main() {
  GovernanceRegistry.flush();
  final app = ClinicApplication();
  
  // Register all intents manually as per the latest GovernanceRegistry pattern
  for (final module in app.modules) {
    for (final screen in module.screens) {
      GovernanceRegistry.register(screen, role: screen.requiredRole?.nameSnake);
    }
  }

  final auditResult = GovernanceRegistry.performDomainAudit();
  
  print('==============================');
  print('DOMAIN AUDIT RESULTS');
  print('==============================');
  print('Integrity Score: \${(auditResult.integrityScore).toStringAsFixed(2)}%');
  print('Total Configured Roles: \${auditResult.totalRoles}');
  print('Fully Implemented Roles: \${auditResult.realizedRoles.length}');
  print('Pending Implementations: \${auditResult.pendingRoles.length}');
  print('==============================');
  
  if (auditResult.integrityScore == 100.0) {
    print('SUCCESS: 100% Realization achieved.');
  } else {
    print('WARNING: System is not fully realized.');
  }
}
