// Governance - Category: service | Purpose: Core implementation file for the Production Readiness Service platform logic.
import 'package:flutter_core/flutter_core.dart';

class ProductionReadinessService {
  static List<PlatformAuditIssue> scan(ScreenMetadata s) {
    final issues = <PlatformAuditIssue>[];

    final isMissingVitals =
        !s.isRenderOk ||
        !s.isAccessibilityVerified ||
        !s.isPerformanceVerified ||
        !_hasVerificationReference(s);

    if (s.deploymentEnvironment == 'production' && isMissingVitals) {
      issues.add(
        PlatformAuditIssue(
          id: 'prod_missing_vitals_${s.id}',
          title: 'Production Vitals Failed',
          category: GovernanceCategory.performance,
          screenId: s.id,
          subsystem: 'primecare_governance',
          registry: 'ProductionReadiness',
          issue: 'Screen targeted for production but fails vitals check (Render/A11y/Perf).',
          suggestion: 'Complete all verification checklists and generate a final audit hash.',
          severity: AuditSeverity.critical,
          metadata: {
            'owner': s.assignedDeveloper,
          },
        ),
      );
    }

    // New Production Readiness Checks
    if (s.deploymentEnvironment == 'production') {
      if (!s.isLocalizationReady) {
        issues.add(
          PlatformAuditIssue(
            id: 'prod_missing_i18n_${s.id}',
            title: 'Localization Incomplete',
            category: GovernanceCategory.compliance,
            screenId: s.id,
            subsystem: 'primecare_governance',
            registry: 'Compliance',
            issue: 'Production screen is not localization ready.',
            suggestion: 'Extract hardcoded strings to i18n bundles.',
            severity: AuditSeverity.high,
            metadata: {
              'owner': s.assignedDeveloper,
            },
          ),
        );
      }

      if (!s.isMobileVerified || !s.isDesktopVerified) {
        issues.add(
          PlatformAuditIssue(
            id: 'prod_missing_device_verif_${s.id}',
            title: 'Device Verification Pending',
            category: GovernanceCategory.performance,
            screenId: s.id,
            subsystem: 'primecare_governance',
            registry: 'ProductionReadiness',
            issue: 'Screen lacks cross-device verification (Mobile/Desktop).',
            suggestion: 'Test layout on target devices and update registry.',
            severity: AuditSeverity.medium,
            metadata: {
              'owner': s.assignedDeveloper,
            },
          ),
        );
      }
    }

    if (s.uatApprover == 'Antigravity-AI') {
      issues.add(
        PlatformAuditIssue(
          id: 'prod_ai_uat_only_${s.id}',
          title: 'Manual UAT Required',
          category: GovernanceCategory.lifecycle,
          screenId: s.id,
          subsystem: 'primecare_governance',
          registry: 'ProductionReadiness',
          issue: 'Screen only has AI-level UAT approval.',
          suggestion: 'A human product owner must review and sign off on this feature.',
          severity: AuditSeverity.medium,
          metadata: {
            'owner': s.assignedDeveloper,
          },
        ),
      );
    }

    return issues;
  }

  static bool isReady(ScreenMetadata screen) => readinessBlockers(screen).isEmpty;

  /// Pending evidence, not permission to certify a screen by changing flags.
  static List<String> readinessBlockers(ScreenMetadata screen) => [
    if (!screen.isRenderOk) 'render-unverified',
    if (!screen.isAccessibilityVerified) 'accessibility-unverified',
    if (!screen.isPerformanceVerified) 'performance-unverified',
    if (!screen.isMobileVerified) 'mobile-unverified',
    if (!screen.isDesktopVerified) 'desktop-unverified',
    if (!screen.testPassRate.isFinite || screen.testPassRate < 95 || screen.testPassRate > 100)
      'test-evidence-invalid-or-below-95-percent',
    if (!_hasVerificationReference(screen)) 'verification-reference-missing-or-placeholder',
    if (!_hasReviewReference(screen)) 'review-reference-missing-or-placeholder',
    if (screen.lifecycleStatus != LifecycleStatus.completed) 'lifecycle-not-completed',
    if (!screen.isLocalizationReady) 'localization-unverified',
    if (!screen.isPhiCompliant) 'phi-compliance-unverified',
  ];

  // Necessary metadata checks only, not independent proof of acceptance.
  // The old startup routine wrote these placeholders without tests or review.
  static bool _hasVerificationReference(ScreenMetadata screen) {
    final value = screen.lastVerificationHash.trim().toLowerCase();
    return value.isNotEmpty &&
        !{'hash_pending', 'verified_by_ci', 'pending', 'none'}.contains(value);
  }

  static bool _hasReviewReference(ScreenMetadata screen) {
    final value = screen.uatApprover.trim().toLowerCase();
    return value.isNotEmpty &&
        !{'none', 'pending', 'unassigned', 'antigravity-ai', 'qa_team'}.contains(value);
  }

}
