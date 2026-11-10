// Governance - Category: test | Purpose: Core implementation file for the Test Quality Audit Service platform logic.
import 'package:flutter_core/flutter_core.dart';

class TestQualityAuditService {
  static bool isValidPassRate(double value) =>
      value.isFinite && value >= 0 && value <= 100;

  static List<PlatformAuditIssue> scan(ScreenMetadata s) {
    final issues = <PlatformAuditIssue>[];

    if (s.testScenarioCount == 0) {
      issues.add(
        PlatformAuditIssue(
          id: 'test_missing_scenarios_${s.id}',
          title: 'Missing Test Scenarios',
          category: GovernanceCategory.testing,
          screenId: s.id,
          subsystem: 'primecare_governance',
          registry: 'Testing',
          issue: 'No test scenarios registered.',
          suggestion: 'Define at least 3 test scenarios (e.g., render, role-check, data-load).',
          severity: AuditSeverity.high,
          metadata: {
            'owner': s.assignedDeveloper,
          },
        ),
      );
    }

    if (!isValidPassRate(s.testPassRate)) {
      issues.add(PlatformAuditIssue(
        id: 'test_invalid_pass_rate_${s.id}',
        title: 'Invalid Test Pass Rate',
        category: GovernanceCategory.testing,
        screenId: s.id,
        subsystem: 'primecare_governance',
        registry: 'Testing',
        issue: 'Test pass rate must be a finite percentage between 0 and 100.',
        suggestion: 'Restore the percentage from actual test results before release.',
        severity: AuditSeverity.high,
        // Store invalid numbers as text so JSON evidence can still be saved.
        metadata: {'owner': s.assignedDeveloper, 'invalidPassRate': s.testPassRate.toString()},
      ));
    } else if (s.testPassRate < 90) {
      issues.add(
        PlatformAuditIssue(
          id: 'test_low_pass_rate_${s.id}',
          title: 'Low Test Pass Rate',
          category: GovernanceCategory.testing,
          screenId: s.id,
          subsystem: 'primecare_governance',
          registry: 'Testing',
          issue: 'Test pass rate (${s.testPassRate}%) is below the 90% threshold.',
          suggestion: 'Debug and resolve failing tests before proceeding.',
          severity: AuditSeverity.high,
          metadata: {
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
          title: 'Insufficient Test Coverage',
          category: GovernanceCategory.testing,
          screenId: s.id,
          subsystem: 'primecare_governance',
          registry: 'Testing',
          issue: 'Very complex screen requires more comprehensive testing (min 10 scenarios).',
          suggestion: 'Add edge-case and performance-focused test scenarios.',
          severity: AuditSeverity.medium,
          metadata: {
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
