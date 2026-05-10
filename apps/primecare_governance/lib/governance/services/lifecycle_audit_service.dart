import 'package:flutter_core/models/governance_types.dart';
import '../../core/governance/screen_registry.dart';

class LifecycleAuditService {
  static List<PlatformAuditIssue> scan(ScreenMetadata s) {
    final issues = <PlatformAuditIssue>[];

    if (s.lifecycleStatus == LifecycleStatus.completed &&
        s.pendingComponents.isNotEmpty) {
      issues.add(
        PlatformAuditIssue(
          id: 'lifecycle_pending_${s.id}',
          subsystem: 'primecare_governance',
          registry: 'Lifecycle',
          issue: 'Completed screen has pending components: ${s.pendingComponents.join(', ')}',
          suggestion: 'Complete all pending work or revert status to testing.',
          severity: AuditSeverity.high,
          metadata: {
            'screenId': s.id,
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
          subsystem: 'primecare_governance',
          registry: 'Lifecycle',
          issue: 'Missing or invalid story point estimation.',
          suggestion: 'Assign a story point weight (1, 2, 3, 5, 8, etc.) for velocity tracking.',
          severity: AuditSeverity.low,
          metadata: {
            'screenId': s.id,
            'owner': s.assignedDeveloper,
          },
        ),
      );
    }

    return issues;
  }
}
