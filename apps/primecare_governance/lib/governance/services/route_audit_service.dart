import '../models/governance_issue.dart';
import '../models/governance_severity.dart';
import '../models/governance_category.dart';
import '../../core/governance/screen_registry.dart';

class RouteAuditService {
  static List<GovernanceIssue> scan(ScreenMetadata s) {
    final issues = <GovernanceIssue>[];

    if (!s.routePath.startsWith('/')) {
      issues.add(GovernanceIssue(
        screenId: s.id,
        title: s.title,
        routePath: s.routePath,
        category: GovernanceCategory.routing,
        severity: GovernanceSeverity.critical,
        message: 'Invalid route path: ${s.routePath}',
        fix: 'Route path must start with a forward slash (/).',
        owner: s.assignedDeveloper,
        sprintName: s.sprintName,
        sourcePath: s.sourcePath,
        detectedAt: DateTime.now(),
      ));
    }

    if (s.routePath.length > 1 && s.routePath.endsWith('/')) {
      issues.add(GovernanceIssue(
        screenId: s.id,
        title: s.title,
        routePath: s.routePath,
        category: GovernanceCategory.routing,
        severity: GovernanceSeverity.low,
        message: 'Trailing slash in route path.',
        fix: 'Remove the trailing slash for consistency.',
        owner: s.assignedDeveloper,
        sprintName: s.sprintName,
        sourcePath: s.sourcePath,
        detectedAt: DateTime.now(),
      ));
    }

    return issues;
  }
}
