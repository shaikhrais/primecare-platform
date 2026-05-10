import 'package:flutter_core/models/governance_types.dart';
import '../../core/governance/screen_registry.dart';

class ProductionReadinessService {
  static List<PlatformAuditIssue> scan(ScreenMetadata s) {
    final issues = <PlatformAuditIssue>[];

    final isMissingVitals =
        !s.isRenderOk ||
        !s.isAccessibilityVerified ||
        !s.isPerformanceVerified ||
        s.lastVerificationHash == 'HASH_PENDING';

    if (s.deploymentEnvironment == 'production' && isMissingVitals) {
      issues.add(
        PlatformAuditIssue(
          id: 'prod_missing_vitals_${s.id}',
          subsystem: 'primecare_governance',
          registry: 'ProductionReadiness',
          issue: 'Screen targeted for production but fails vitals check (Render/A11y/Perf).',
          suggestion: 'Complete all verification checklists and generate a final audit hash.',
          severity: AuditSeverity.critical,
          metadata: {
            'screenId': s.id,
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
            subsystem: 'primecare_governance',
            registry: 'Compliance',
            issue: 'Production screen is not localization ready.',
            suggestion: 'Extract hardcoded strings to i18n bundles.',
            severity: AuditSeverity.high,
            metadata: {
              'screenId': s.id,
              'owner': s.assignedDeveloper,
              'fixProperty': 'isLocalizationReady',
              'fixValue': 'true',
            },
          ),
        );
      }

      if (!s.isMobileVerified || !s.isDesktopVerified) {
        issues.add(
          PlatformAuditIssue(
            id: 'prod_missing_device_verif_${s.id}',
            subsystem: 'primecare_governance',
            registry: 'ProductionReadiness',
            issue: 'Screen lacks cross-device verification (Mobile/Desktop).',
            suggestion: 'Test layout on target devices and update registry.',
            severity: AuditSeverity.medium,
            metadata: {
              'screenId': s.id,
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
          subsystem: 'primecare_governance',
          registry: 'ProductionReadiness',
          issue: 'Screen only has AI-level UAT approval.',
          suggestion: 'A human product owner must review and sign off on this feature.',
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
