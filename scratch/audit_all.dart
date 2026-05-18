import 'package:flutter_core/registry/governance_registry.dart';
import 'package:primecare_clinic/core/routing/clinic_routes.dart';
import 'package:primecare_support/core/routing/support_routes.dart';
import 'package:primecare_marketing/core/routing/marketing_routes.dart';
import 'package:primecare_governance/core/routing/governance_application.dart';
import 'package:primecare_franchise/core/routing/franchise_routes.dart';
import 'package:primecare_corporate/core/routing/corporate_routes.dart';
import 'package:primecare_client/core/routing/client_routes.dart';
import 'package:primecare_business_development/core/routing/business_development_routes.dart';
import 'package:flutter_core/registry/platform_role.dart';

void main() {
  GovernanceRegistry.flush();
  
  final apps = [
    ClinicApplication(),
    SupportApplication(),
    MarketingApplication(),
    GovernanceApplication(),
    FranchiseApplication(),
    CorporateApplication(),
    ClientApplication(),
    BusinessDevelopmentApplication(),
  ];
  
  for (final app in apps) {
    for (final module in app.modules) {
      for (final screen in module.screens) {
        GovernanceRegistry.register(screen, role: screen.requiredRole?.nameSnake);
      }
    }
  }

  final auditResult = GovernanceRegistry.performDomainAudit();
  
  print('==============================');
  print('GLOBAL DOMAIN AUDIT RESULTS');
  print('==============================');
  print('Integrity Score: \${(auditResult.integrityScore).toStringAsFixed(2)}%');
  print('Total Configured Roles: \${auditResult.totalRoles}');
  print('Fully Implemented Roles: \${auditResult.realizedRoles.length}');
  print('Pending Implementations: \${auditResult.pendingRoles.length}');
  print('==============================');
  print('Pending Roles:');
  for (final r in auditResult.pendingRoles) {
    print(' - \${r.name}');
  }
}
