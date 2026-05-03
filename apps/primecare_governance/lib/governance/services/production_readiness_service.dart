import '../models/governance_issue.dart';
import '../models/governance_severity.dart';
import '../models/governance_category.dart';
import '../../core/governance/screen_registry.dart';

class ProductionReadinessService {
  static List<GovernanceIssue> scan(ScreenMetadata s) {
    final issues = <GovernanceIssue>[];

    final isMissingVitals = !s.isRenderOk || 
                            !s.isAccessibilityVerified || 
                            !s.isPerformanceVerified ||
                            s.lastVerificationHash == 'HASH_PENDING';

    if (s.deploymentEnvironment == 'production' && isMissingVitals) {
      issues.add(GovernanceIssue(
        screenId: s.id,
        title: s.title,
        routePath: s.routePath,
        category: GovernanceCategory.production,
        severity: GovernanceSeverity.critical,
        message: 'Screen targeted for production but fails vitals check (Render/A11y/Perf).',
        fix: 'Complete all verification checklists and generate a final audit hash.',
        owner: s.assignedDeveloper,
        sprintName: s.sprintName,
        sourcePath: s.sourcePath,
        detectedAt: DateTime.now(),
      ));
    }

    // New Production Readiness Checks
    if (s.deploymentEnvironment == 'production') {
      if (!s.isLocalizationReady) {
        issues.add(GovernanceIssue(
          screenId: s.id,
          title: s.title,
          routePath: s.routePath,
          category: GovernanceCategory.compliance,
          severity: GovernanceSeverity.high,
          message: 'Production screen is not localization ready.',
          fix: 'Extract hardcoded strings to i18n bundles.',
          owner: s.assignedDeveloper,
          sprintName: s.sprintName,
          sourcePath: s.sourcePath,
          fixProperty: 'isLocalizationReady',
          fixValue: 'true',
          detectedAt: DateTime.now(),
        ));
      }

      if (!s.isMobileVerified || !s.isDesktopVerified) {
        issues.add(GovernanceIssue(
          screenId: s.id,
          title: s.title,
          routePath: s.routePath,
          category: GovernanceCategory.production,
          severity: GovernanceSeverity.medium,
          message: 'Screen lacks cross-device verification (Mobile/Desktop).',
          fix: 'Test layout on target devices and update registry.',
          owner: s.assignedDeveloper,
          sprintName: s.sprintName,
          sourcePath: s.sourcePath,
          detectedAt: DateTime.now(),
        ));
      }
    }

    if (s.uatApprover == 'Antigravity-AI') {
      issues.add(GovernanceIssue(
        screenId: s.id,
        title: s.title,
        routePath: s.routePath,
        category: GovernanceCategory.production,
        severity: GovernanceSeverity.medium,
        message: 'Screen only has AI-level UAT approval.',
        fix: 'A human product owner must review and sign off on this feature.',
        owner: s.assignedDeveloper,
        sprintName: s.sprintName,
        sourcePath: s.sourcePath,
        detectedAt: DateTime.now(),
      ));
    }

    return issues;
  }

  static bool isReady(ScreenMetadata s) {
    return s.isRenderOk &&
           s.isAccessibilityVerified &&
           s.isPerformanceVerified &&
           s.testPassRate >= 95 &&
           s.lastVerificationHash != 'HASH_PENDING' &&
           s.uatApprover != 'Antigravity-AI' &&
           s.lifecycleStatus == LifecycleStatus.completed &&
           s.isLocalizationReady &&
           s.isPhiCompliant;
  }
}
