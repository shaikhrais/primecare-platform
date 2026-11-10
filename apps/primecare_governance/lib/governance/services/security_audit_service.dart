// Governance - Category: service | Purpose: 1. Role Verification
import 'package:flutter_core/flutter_core.dart';

class SecurityAuditService {
  static List<PlatformAuditIssue> scan(ScreenMetadata s) {
    final issues = <PlatformAuditIssue>[];

    // 1. Role Verification
    if (s.allowedRoles.isEmpty) {
      issues.add(
        PlatformAuditIssue(
          id: 'security_missing_roles_${s.id}',
          title: 'Missing Security Roles',
          category: GovernanceCategory.security,
          screenId: s.id,
          subsystem: 'primecare_governance',
          registry: 'Security',
          issue: 'No roles assigned to screen. Accessible by none.',
          suggestion: 'Reconcile the exact screen identity and grants with authoritative governance metadata; keep access denied until resolved.',
          severity: AuditSeverity.critical,
          metadata: {
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
          title: 'PHI Non-Compliant',
          category: GovernanceCategory.security,
          screenId: s.id,
          subsystem: 'primecare_governance',
          registry: 'Security',
          issue: 'High-security screen is not PHI compliant.',
          suggestion: 'Complete a PHI review and attach its evidence before recording compliance.',
          severity: AuditSeverity.critical,
          metadata: {
            'owner': s.assignedDeveloper,
          },
        ),
      );
    }

    // 3. Sensitive Data without Guard
    if (s.securityLevel == SecurityTier.high && !s.hasUnsavedChangeGuard) {
      issues.add(
        PlatformAuditIssue(
          id: 'security_missing_guard_${s.id}',
          title: 'Missing Change Guard',
          category: GovernanceCategory.compliance,
          screenId: s.id,
          subsystem: 'primecare_governance',
          registry: 'Compliance',
          issue: 'Sensitive data screen lacks Unsaved Change Guard.',
          suggestion: 'Implement and test UnsavedChangeGuard, then record the verified result.',
          severity: AuditSeverity.medium,
          metadata: {
            'owner': s.assignedDeveloper,
          },
        ),
      );
    }

    // 4. Permission Mismatch
    if (s.allowedRoles.contains('admin') && s.requiredPermissions.isEmpty) {
      issues.add(
        PlatformAuditIssue(
          id: 'security_missing_perms_${s.id}',
          title: 'Missing Permissions',
          category: GovernanceCategory.security,
          screenId: s.id,
          subsystem: 'primecare_governance',
          registry: 'Security',
          issue: 'Admin screen has no requiredPermissions listed.',
          suggestion: 'Document specific fine-grained permissions required for this screen.',
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
