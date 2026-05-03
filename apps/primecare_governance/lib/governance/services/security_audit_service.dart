import '../models/governance_issue.dart';
import '../models/governance_severity.dart';
import '../models/governance_category.dart';
import '../../core/governance/screen_registry.dart';

class SecurityAuditService {
  static List<GovernanceIssue> scan(ScreenMetadata s) {
    final issues = <GovernanceIssue>[];

    // 1. Role Verification
    if (s.allowedRoles.isEmpty) {
      issues.add(GovernanceIssue(
        screenId: s.id,
        title: s.title,
        routePath: s.routePath,
        category: GovernanceCategory.security,
        severity: GovernanceSeverity.critical,
        message: 'No roles assigned to screen. Accessible by none.',
        fix: 'Assign at least one valid role (e.g., admin, manager).',
        owner: s.assignedDeveloper,
        sprintName: s.sprintName,
        sourcePath: s.sourcePath,
        detectedAt: DateTime.now(),
      ));
    }

    // 2. PHI Compliance for High-Risk Screens
    if ((s.securityLevel == SecurityTier.high || s.securityLevel == SecurityTier.internal) && !s.isPhiCompliant) {
      issues.add(GovernanceIssue(
        screenId: s.id,
        title: s.title,
        routePath: s.routePath,
        category: GovernanceCategory.security,
        severity: GovernanceSeverity.critical,
        message: 'High-security screen is not PHI compliant.',
        fix: 'Perform PHI audit and set isPhiCompliant to true.',
        owner: s.assignedDeveloper,
        sprintName: s.sprintName,
        sourcePath: s.sourcePath,
        fixProperty: 'isPhiCompliant',
        fixValue: 'true',
        detectedAt: DateTime.now(),
      ));
    }

    // 3. Sensitive Data without Guard
    if (s.securityLevel == SecurityTier.high && !s.hasUnsavedChangeGuard) {
      issues.add(GovernanceIssue(
        screenId: s.id,
        title: s.title,
        routePath: s.routePath,
        category: GovernanceCategory.compliance,
        severity: GovernanceSeverity.medium,
        message: 'Sensitive data screen lacks Unsaved Change Guard.',
        fix: 'Implement UnsavedChangeGuard in the UI and update registry.',
        owner: s.assignedDeveloper,
        sprintName: s.sprintName,
        sourcePath: s.sourcePath,
        fixProperty: 'hasUnsavedChangeGuard',
        fixValue: 'true',
        detectedAt: DateTime.now(),
      ));
    }

    // 4. Permission Mismatch
    if (s.allowedRoles.contains('admin') && s.requiredPermissions.isEmpty) {
       issues.add(GovernanceIssue(
        screenId: s.id,
        title: s.title,
        routePath: s.routePath,
        category: GovernanceCategory.security,
        severity: GovernanceSeverity.low,
        message: 'Admin screen has no requiredPermissions listed.',
        fix: 'Document specific fine-grained permissions required for this screen.',
        owner: s.assignedDeveloper,
        sprintName: s.sprintName,
        sourcePath: s.sourcePath,
        detectedAt: DateTime.now(),
      ));
    }

    return issues;
  }
}
