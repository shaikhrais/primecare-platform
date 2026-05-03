import '../models/governance_issue.dart';
import '../models/governance_severity.dart';
import '../models/governance_category.dart';
import '../../core/governance/screen_registry.dart';

class TestQualityAuditService {
  static List<GovernanceIssue> scan(ScreenMetadata s) {
    final issues = <GovernanceIssue>[];

    if (s.testScenarioCount == 0) {
      issues.add(GovernanceIssue(
        screenId: s.id,
        title: s.title,
        routePath: s.routePath,
        category: GovernanceCategory.testing,
        severity: GovernanceSeverity.high,
        message: 'No test scenarios registered.',
        fix: 'Define at least 3 test scenarios (e.g., render, role-check, data-load).',
        owner: s.assignedDeveloper,
        sprintName: s.sprintName,
        sourcePath: s.sourcePath,
        detectedAt: DateTime.now(),
      ));
    }

    if (s.testPassRate < 90) {
      issues.add(GovernanceIssue(
        screenId: s.id,
        title: s.title,
        routePath: s.routePath,
        category: GovernanceCategory.testing,
        severity: GovernanceSeverity.high,
        message: 'Test pass rate (${s.testPassRate}%) is below the 90% threshold.',
        fix: 'Debug and resolve failing tests before proceeding.',
        owner: s.assignedDeveloper,
        sprintName: s.sprintName,
        sourcePath: s.sourcePath,
        detectedAt: DateTime.now(),
      ));
    }

    if (s.complexity > 8 && s.testScenarioCount < 10) {
      issues.add(GovernanceIssue(
        screenId: s.id,
        title: s.title,
        routePath: s.routePath,
        category: GovernanceCategory.testing,
        severity: GovernanceSeverity.medium,
        message: 'Very complex screen requires more comprehensive testing (min 10 scenarios).',
        fix: 'Add edge-case and performance-focused test scenarios.',
        owner: s.assignedDeveloper,
        sprintName: s.sprintName,
        sourcePath: s.sourcePath,
        detectedAt: DateTime.now(),
      ));
    }

    return issues;
  }
}
