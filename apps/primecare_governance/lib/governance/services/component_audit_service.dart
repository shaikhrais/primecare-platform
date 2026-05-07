import '../models/governance_issue.dart';
import '../models/governance_severity.dart';
import '../models/governance_category.dart';
import '../../core/governance/screen_registry.dart';

class ComponentAuditService {
  static List<GovernanceIssue> scan(ScreenMetadata s) {
    final issues = <GovernanceIssue>[];

    if (s.lifecycleStatus == LifecycleStatus.completed &&
        s.implementedComponents.isEmpty) {
      issues.add(
        GovernanceIssue(
          screenId: s.id,
          title: s.title,
          routePath: s.routePath,
          category: GovernanceCategory.component,
          severity: GovernanceSeverity.high,
          message: 'No implemented components registered for completed screen.',
          fix:
              'Add the core widgets used in this screen to implementedComponents.',
          owner: s.assignedDeveloper,
          sprintName: s.sprintName,
          sourcePath: s.sourcePath,
          detectedAt: DateTime.now(),
        ),
      );
    }

    if (s.complexity > 5 && s.implementedComponents.length < 3) {
      issues.add(
        GovernanceIssue(
          screenId: s.id,
          title: s.title,
          routePath: s.routePath,
          category: GovernanceCategory.component,
          severity: GovernanceSeverity.medium,
          message:
              'High-complexity screen with minimal component documentation.',
          fix: 'Provide a detailed breakdown of the components used.',
          owner: s.assignedDeveloper,
          sprintName: s.sprintName,
          sourcePath: s.sourcePath,
          detectedAt: DateTime.now(),
        ),
      );
    }

    return issues;
  }
}
