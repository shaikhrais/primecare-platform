import 'package:flutter_core/models/governance_types.dart';
import '../../core/governance/screen_registry.dart';

class RbacAuditService {
  static List<PlatformAuditIssue> scan(ScreenMetadata s) {
    final issues = <PlatformAuditIssue>[];

    if (s.allowedRoles.isEmpty) {
      issues.add(
        PlatformAuditIssue(
          id: 'rbac_missing_${s.id}',
          subsystem: 'primecare_governance',
          registry: 'RBAC',
          issue: 'No roles assigned to screen.',
          suggestion: 'Add at least one role to allowedRoles to ensure security coverage.',
          severity: AuditSeverity.critical,
          metadata: {
            'screenId': s.id,
            'owner': s.assignedDeveloper,
          },
        ),
      );
    }

    if (s.securityLevel == SecurityTier.high &&
        s.allowedRoles.contains('guest')) {
      issues.add(
        PlatformAuditIssue(
          id: 'rbac_guest_leak_${s.id}',
          subsystem: 'primecare_governance',
          registry: 'RBAC',
          issue: 'Guest role allowed on high-security screen.',
          suggestion: 'Remove "guest" role from allowedRoles for this sensitive feature.',
          severity: AuditSeverity.high,
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
