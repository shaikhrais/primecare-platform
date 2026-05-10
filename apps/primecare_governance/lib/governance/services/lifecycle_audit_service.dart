import 'package:flutter_core/flutter_core.dart';

class LifecycleAuditService {
  static List<PlatformAuditIssue> scan(ScreenMetadata s) {
    final issues = <PlatformAuditIssue>[];

    if (s.lifecycleStatus == LifecycleStatus.completed &&
        s.pendingComponents.isNotEmpty) {
      issues.add(
        PlatformAuditIssue(
          id: 'lifecycle_pending_${s.id}',
          title: 'Pending Work in Completed Screen',
          category: GovernanceCategory.lifecycle,
          screenId: s.id,
          subsystem: 'primecare_governance',
          registry: 'Lifecycle',
          issue: 'Completed screen has pending components: ${s.pendingComponents.join(', ')}',
          suggestion: 'Complete all pending work or revert status to testing.',
          severity: AuditSeverity.high,
          metadata: {
            'owner': s.assignedDeveloper,
            'sprint': s.sprintName,
          },
        ),
      );
    }

    if (s.storyPoints <= 0) {
      issues.add(
        PlatformAuditIssue(
          id: 'lifecycle_points_${s.id}',
          title: 'Missing Story Points',
          category: GovernanceCategory.lifecycle,
          screenId: s.id,
          subsystem: 'primecare_governance',
          registry: 'Lifecycle',
          issue: 'Missing or invalid story point estimation.',
          suggestion: 'Assign a story point weight (1, 2, 3, 5, 8, etc.) for velocity tracking.',
          severity: AuditSeverity.low,
          metadata: {
            'owner': s.assignedDeveloper,
          },
        ),
      );
    }

    return issues;
  }
}
