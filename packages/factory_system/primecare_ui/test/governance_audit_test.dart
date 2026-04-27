import 'package:primecare_ui/primecare_ui.dart';
import 'package:primecare_ui/src/registry/platform_governance_audit.dart';

void main() {
  print('--- PrimeCare Governance Integrity Audit ---');

  // We need a mock ref or a way to bypass it for labels
  final audit = PlatformGovernanceAudit.performAudit(null);

  print(audit.toString());
  print('\nDetailed Component Mapping:');

  for (final role in audit.realizedRoles) {
    final health = audit.healthReports[role];
    print(
      '[$role]: ${health?.componentLabels.join(', ') ?? 'NO COMPONENTS REGISTERED'}',
    );
  }
}
