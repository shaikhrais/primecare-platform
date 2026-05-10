import 'package:flutter_core/flutter_core.dart';

class RbacAuditService {
  static List<PlatformAuditIssue> scan(ScreenMetadata s) {
    final issues = <PlatformAuditIssue>[];

    if (s.allowedRoles.isEmpty) {
      issues.add(
        PlatformAuditIssue(
          id: 'rbac_missing_${s.id}',
          title: 'Missing RBAC Configuration',
          category: GovernanceCategory.rbac,
          screenId: s.id,
          subsystem: 'primecare_governance',
          registry: 'RBAC',
          issue: 'No roles assigned to screen.',
          suggestion: 'Add at least one role to allowedRoles to ensure security coverage.',
          severity: AuditSeverity.critical,
          metadata: {
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
          title: 'Guest Access Leak',
          category: GovernanceCategory.rbac,
          screenId: s.id,
          subsystem: 'primecare_governance',
          registry: 'RBAC',
          issue: 'Guest role allowed on high-security screen.',
          suggestion: 'Remove "guest" role from allowedRoles for this sensitive feature.',
          severity: AuditSeverity.high,
          metadata: {
            'owner': s.assignedDeveloper,
          },
        ),
      );
    }

    return issues;
  }
}
