import 'package:flutter_core/flutter_core.dart';
import '../automated_audit_engine.dart';

class LayoutAuditor {
  static List<AuditResultItem> audit(List<ScreenMetadata> screens) {
    final results = <AuditResultItem>[];

    int layoutUnapproved = 0;
    int missingBreakpoints = 0;
    int missingHifiSpecs = 0;
    int lowCompletion = 0;

    for (final screen in screens) {
      if (!screen.userApprovedLayout) {
        layoutUnapproved++;
      }
      if (!screen.isMobileVerified ||
          !screen.isTabletVerified ||
          !screen.isDesktopVerified) {
        missingBreakpoints++;
      }
      // Check for 4K readiness (designSize >= 3840 width)
      if (screen.designSize.width < 3840) {
        // We only warn for now if it's below 4K, as some legacy screens might be smaller.
        // But for Clinical/Logistics, 4K is the new standard.
        missingHifiSpecs++;
      }
      if (screen.completionPercent < 50 &&
          screen.lifecycleStatus != LifecycleStatus.backlog) {
        lowCompletion++;
      }
    }

    results.add(
      AuditResultItem(
        check: 'Implementation Velocity Audit',
        result: lowCompletion == 0 ? 'PASSED' : 'WARNING',
        isPass: true,
        isWarning: lowCompletion > 0,
        meaning: lowCompletion == 0
            ? 'Platform-wide implementation velocity is within healthy parameters (>50%).'
            : '$lowCompletion screens are currently in high-drift state (<50% complete).',
        fix:
            'Accelerate high-fidelity UI hydration or update blueprint completion stats.',
      ),
    );

    results.add(
      AuditResultItem(
        check: 'UX Layout Sign-off',
        result: layoutUnapproved == 0 ? 'PASSED' : 'FAILED',
        isPass: layoutUnapproved == 0,
        meaning: layoutUnapproved == 0
            ? 'All UI layouts have been formally approved by Product/Design.'
            : '$layoutUnapproved screens are awaiting layout approval.',
        fix:
            'Trigger "Layout Sign-off" workflow in Verification Center after design review.',
      ),
    );

    results.add(
      AuditResultItem(
        check: 'Responsive Breakpoint Audit',
        result: missingBreakpoints == 0 ? 'PASSED' : 'WARNING',
        isPass: true,
        isWarning: missingBreakpoints > 0,
        meaning: missingBreakpoints == 0
            ? 'All screens verified for Mobile, Tablet, and Desktop.'
            : '$missingBreakpoints screens have unverified responsive breakpoints.',
        fix:
            'Verify UI stability on all device form-factors and update verification flags.',
      ),
    );

    results.add(
      AuditResultItem(
        check: '4K High-Fidelity Target',
        result: missingHifiSpecs == 0 ? 'PASSED' : 'WARNING',
        isPass: true,
        isWarning: missingHifiSpecs > 0,
        meaning: missingHifiSpecs == 0
            ? 'All screens targeting 4K high-fidelity (3840x2160) canvas.'
            : '$missingHifiSpecs screens are missing 4K high-fidelity design specifications.',
        fix:
            'Update ScreenMetadata with designSize: Size(3840, 2160) in CoreGovernanceRegistry.',
      ),
    );

    return results;
  }
}
