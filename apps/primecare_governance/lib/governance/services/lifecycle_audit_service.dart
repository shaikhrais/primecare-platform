import '../models/governance_issue.dart';
import '../models/governance_severity.dart';
import '../models/governance_category.dart';
import '../../core/governance/screen_registry.dart';

class LifecycleAuditService {
  static List<GovernanceIssue> scan(ScreenMetadata s) {
    final issues = <GovernanceIssue>[];

    if (s.lifecycleStatus == LifecycleStatus.completed && s.pendingComponents.isNotEmpty) {
      issues.add(GovernanceIssue(
        screenId: s.id,
        title: s.title,
        routePath: s.routePath,
        category: GovernanceCategory.lifecycle,
        severity: GovernanceSeverity.high,
        message: 'Completed screen has pending components: ${s.pendingComponents.join(', ')}',
        fix: 'Complete all pending work or revert status to testing.',
        owner: s.assignedDeveloper,
        sprintName: s.sprintName,
        sourcePath: s.sourcePath,
        detectedAt: DateTime.now(),
      ));
    }

    if (s.storyPoints <= 0) {
      issues.add(GovernanceIssue(
        screenId: s.id,
        title: s.title,
        routePath: s.routePath,
        category: GovernanceCategory.lifecycle,
        severity: GovernanceSeverity.low,
        message: 'Missing or invalid story point estimation.',
        fix: 'Assign a story point weight (1, 2, 3, 5, 8, etc.) for velocity tracking.',
        owner: s.assignedDeveloper,
        sprintName: s.sprintName,
        sourcePath: s.sourcePath,
        detectedAt: DateTime.now(),
      ));
    }

    return issues;
  }
}
