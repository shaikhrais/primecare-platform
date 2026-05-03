import '../models/governance_issue.dart';
import '../models/governance_severity.dart';
import '../models/governance_category.dart';
import '../../core/governance/screen_registry.dart';

class RbacAuditService {
  static List<GovernanceIssue> scan(ScreenMetadata s) {
    final issues = <GovernanceIssue>[];

    if (s.allowedRoles.isEmpty) {
      issues.add(GovernanceIssue(
        screenId: s.id,
        title: s.title,
        routePath: s.routePath,
        category: GovernanceCategory.rbac,
        severity: GovernanceSeverity.critical,
        message: 'No roles assigned to screen.',
        fix: 'Add at least one role to allowedRoles to ensure security coverage.',
        owner: s.assignedDeveloper,
        sprintName: s.sprintName,
        sourcePath: s.sourcePath,
        detectedAt: DateTime.now(),
      ));
    }

    if (s.securityLevel == SecurityTier.high && s.allowedRoles.contains('guest')) {
      issues.add(GovernanceIssue(
        screenId: s.id,
        title: s.title,
        routePath: s.routePath,
        category: GovernanceCategory.rbac,
        severity: GovernanceSeverity.high,
        message: 'Guest role allowed on high-security screen.',
        fix: 'Remove "guest" role from allowedRoles for this sensitive feature.',
        owner: s.assignedDeveloper,
        sprintName: s.sprintName,
        sourcePath: s.sourcePath,
        detectedAt: DateTime.now(),
      ));
    }

    return issues;
  }
}
