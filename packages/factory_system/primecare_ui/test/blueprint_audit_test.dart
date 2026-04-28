import 'package:primecare_ui/src/governance_bootstrapper.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_core/flutter_core.dart';

void main() {
  group('Auditor Blueprint Governance Tests', () {
    test('Should seed blueprints and perform structural audit', () {
      // 1. Bootstrap
      GovernanceBootstrapper.bootstrap();

      final blueprints = BlueprintRegistry.getAll();
      expect(blueprints.length, greaterThanOrEqualTo(4));

      print('Blueprints Registered: ${blueprints.length}');

      // 2. Perform Audit
      final auditResults = GovernanceRegistry.performBlueprintAudit();

      final failures = auditResults
          .where((r) => r.missingLabels.isNotEmpty)
          .toList();

      print('\n--- Blueprint Compliance Audit ---');
      for (var result in failures) {
        print(result.toString());
        final intent = GovernanceRegistry.getIntentByRoute(result.route);
        print('Actual Labels: ${intent?.componentLabels}');
      }
      expect(failures, isEmpty);

      // 3. Global Audit Report
      final globalReport = GovernanceRegistry.performDomainAudit();
      print('\n--- Global Governance Report ---');
      print('Integrity Score: \${globalReport.integrityScore}');
      expect(globalReport.integrityScore, greaterThan(0));
    });
  });
}
