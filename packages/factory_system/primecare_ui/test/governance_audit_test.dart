import 'package:flutter_test/flutter_test.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'package:primecare_ui/src/platform_governance_audit.dart';

void main() {
  test('PrimeCare Governance Integrity Audit', () {
    print('--- PrimeCare Governance Integrity Audit ---');

    // We need a mock ref or a way to bypass it for labels
    final audit = PlatformGovernanceAudit.performAudit(null);

    print(audit.toString());

    print('\nPending Roles:');
    for (final role in audit.pendingRoles) {
      print('  - $role');
    }

    print('\nDetailed Component Mapping:');

    for (final role in audit.realizedRoles) {
      final health = audit.healthReports[role];
      print(
        '[$role]: ${health?.componentLabels.join(', ') ?? 'NO COMPONENTS REGISTERED'}',
      );
    }

    expect(audit.integrityScore, greaterThanOrEqualTo(88.0));
  });
}
