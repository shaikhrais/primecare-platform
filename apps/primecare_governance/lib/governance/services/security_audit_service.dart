import 'package:flutter_core/models/governance_types.dart';
import '../../core/governance/screen_registry.dart';

class SecurityAuditService {
  static List<PlatformAuditIssue> scan(ScreenMetadata s) {
    final issues = <PlatformAuditIssue>[];

    // 1. Role Verification
    if (s.allowedRoles.isEmpty) {
      issues.add(
        PlatformAuditIssue(
          id: 'security_missing_roles_${s.id}',
          subsystem: 'primecare_governance',
          registry: 'Security',
          issue: 'No roles assigned to screen. Accessible by none.',
          suggestion: 'Assign at least one valid role (e.g., admin, manager).',
          severity: AuditSeverity.critical,
          metadata: {
            'screenId': s.id,
            'owner': s.assignedDeveloper,
          },
        ),
      );
    }

    // 2. PHI Compliance for High-Risk Screens
    if ((s.securityLevel == SecurityTier.high ||
            s.securityLevel == SecurityTier.internal) &&
        !s.isPhiCompliant) {
      issues.add(
        PlatformAuditIssue(
          id: 'security_phi_noncompliant_${s.id}',
          subsystem: 'primecare_governance',
          registry: 'Security',
          issue: 'High-security screen is not PHI compliant.',
          suggestion: 'Perform PHI audit and set isPhiCompliant to true.',
          severity: AuditSeverity.critical,
          autoRemediable: true,
          metadata: {
            'screenId': s.id,
            'owner': s.assignedDeveloper,
            'fixProperty': 'isPhiCompliant',
            'fixValue': 'true',
          },
        ),
      );
    }

    // 3. Sensitive Data without Guard
    if (s.securityLevel == SecurityTier.high && !s.hasUnsavedChangeGuard) {
      issues.add(
        PlatformAuditIssue(
          id: 'security_missing_guard_${s.id}',
          subsystem: 'primecare_governance',
          registry: 'Compliance',
          issue: 'Sensitive data screen lacks Unsaved Change Guard.',
          suggestion: 'Implement UnsavedChangeGuard in the UI and update registry.',
          severity: AuditSeverity.medium,
          autoRemediable: true,
          metadata: {
            'screenId': s.id,
            'owner': s.assignedDeveloper,
            'fixProperty': 'hasUnsavedChangeGuard',
            'fixValue': 'true',
          },
        ),
      );
    }

    // 4. Permission Mismatch
    if (s.allowedRoles.contains('admin') && s.requiredPermissions.isEmpty) {
      issues.add(
        PlatformAuditIssue(
          id: 'security_missing_perms_${s.id}',
          subsystem: 'primecare_governance',
          registry: 'Security',
          issue: 'Admin screen has no requiredPermissions listed.',
          suggestion: 'Document specific fine-grained permissions required for this screen.',
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
