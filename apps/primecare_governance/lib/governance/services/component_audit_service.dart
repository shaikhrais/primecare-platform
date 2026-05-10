import 'package:flutter_core/models/governance_types.dart';
import '../../core/governance/screen_registry.dart';

class ComponentAuditService {
  static List<PlatformAuditIssue> scan(ScreenMetadata s) {
    final issues = <PlatformAuditIssue>[];

    if (s.lifecycleStatus == LifecycleStatus.completed &&
        s.implementedComponents.isEmpty) {
      issues.add(
        PlatformAuditIssue(
          id: 'component_missing_${s.id}',
          subsystem: 'primecare_governance',
          registry: 'Component',
          issue: 'No implemented components registered for completed screen.',
          suggestion: 'Add the core widgets used in this screen to implementedComponents.',
          severity: AuditSeverity.high,
          metadata: {
            'screenId': s.id,
            'owner': s.assignedDeveloper,
          },
        ),
      );
    }

    if (s.complexity > 5 && s.implementedComponents.length < 3) {
      issues.add(
        PlatformAuditIssue(
          id: 'component_minimal_${s.id}',
          subsystem: 'primecare_governance',
          registry: 'Component',
          issue: 'High-complexity screen with minimal component documentation.',
          suggestion: 'Provide a detailed breakdown of the components used.',
          severity: AuditSeverity.medium,
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
