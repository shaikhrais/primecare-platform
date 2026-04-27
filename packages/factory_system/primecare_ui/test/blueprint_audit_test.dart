import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_core/flutter_core.dart';

void main() {
  group('Auditor Blueprint Governance Tests', () {
    test('Should seed blueprints and perform structural audit', () {
      // 1. Bootstrap
      GovernanceBootstrapper.bootstrap();

      final blueprints = BlueprintRegistry.getAll();
      expect(blueprints.length, greaterThanOrEqualTo(4));

      print('Blueprints Registered: \${blueprints.length}');

      // 2. Perform Audit
      final auditResults = GovernanceRegistry.performBlueprintAudit();
      expect(auditResults, isNotEmpty);

      print('\n--- Blueprint Compliance Audit ---');
      for (var result in auditResults) {
        print(result.toString());
      }

      // 3. Global Audit Report
      final globalReport = PlatformGovernanceAudit.performAudit(null);
      print('\n--- Global Governance Report ---');
      print(globalReport.toString());

      expect(globalReport.integrityScore, greaterThan(0));
    });
  });
}
