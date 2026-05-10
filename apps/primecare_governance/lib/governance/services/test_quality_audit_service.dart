import 'package:flutter_core/models/governance_types.dart';
import '../../core/governance/screen_registry.dart';

class TestQualityAuditService {
  static List<PlatformAuditIssue> scan(ScreenMetadata s) {
    final issues = <PlatformAuditIssue>[];

    if (s.testScenarioCount == 0) {
      issues.add(
        PlatformAuditIssue(
          id: 'test_missing_scenarios_${s.id}',
          subsystem: 'primecare_governance',
          registry: 'Testing',
          issue: 'No test scenarios registered.',
          suggestion: 'Define at least 3 test scenarios (e.g., render, role-check, data-load).',
          severity: AuditSeverity.high,
          metadata: {
            'screenId': s.id,
            'owner': s.assignedDeveloper,
          },
        ),
      );
    }

    if (s.testPassRate < 90) {
      issues.add(
        PlatformAuditIssue(
          id: 'test_low_pass_rate_${s.id}',
          subsystem: 'primecare_governance',
          registry: 'Testing',
          issue: 'Test pass rate (${s.testPassRate}%) is below the 90% threshold.',
          suggestion: 'Debug and resolve failing tests before proceeding.',
          severity: AuditSeverity.high,
          metadata: {
            'screenId': s.id,
            'owner': s.assignedDeveloper,
            'passRate': s.testPassRate,
          },
        ),
      );
    }

    if (s.complexity > 8 && s.testScenarioCount < 10) {
      issues.add(
        PlatformAuditIssue(
          id: 'test_insufficient_coverage_${s.id}',
          subsystem: 'primecare_governance',
          registry: 'Testing',
          issue: 'Very complex screen requires more comprehensive testing (min 10 scenarios).',
          suggestion: 'Add edge-case and performance-focused test scenarios.',
          severity: AuditSeverity.medium,
          metadata: {
            'screenId': s.id,
            'owner': s.assignedDeveloper,
            'complexity': s.complexity,
            'scenarioCount': s.testScenarioCount,
          },
        ),
      );
    }

    return issues;
  }
}
