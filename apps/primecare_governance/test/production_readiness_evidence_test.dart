import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:primecare_governance/governance/services/production_readiness_service.dart';
import 'package:primecare_governance/governance/services/security_audit_service.dart';

void main() {
  const fixture = ScreenMetadata(id: 'EVIDENCE_FIXTURE', title: 'Fixture',
    route: '/fixture', roles: ['fixture'], lifecycleStatus: LifecycleStatus.completed,
    isRenderOk: true, isAccessibilityVerified: true, isPerformanceVerified: true,
    isMobileVerified: true, isDesktopVerified: true,
    testPassRate: 98, isLocalizationReady: true, isPhiCompliant: true,
    lastVerificationHash: 'fixture-reference-only', uatApprover: 'fixture-reviewer');

  test('empty and manufactured verification references cannot satisfy readiness', () {
    for (final hash in ['', ' ', 'HASH_PENDING', ' VERIFIED_BY_CI ', 'pending', 'none']) {
      expect(ProductionReadinessService.isReady(fixture.copyWith(lastVerificationHash: hash)),
        isFalse, reason: hash);
    }
  });

  test('empty, placeholder and automated approvers cannot satisfy readiness', () {
    for (final reviewer in ['', ' ', 'none', 'None', 'pending', 'unassigned',
      'Antigravity-AI', ' QA_TEAM ']) {
      expect(ProductionReadinessService.isReady(fixture.copyWith(uatApprover: reviewer)),
        isFalse, reason: reviewer);
    }
  });

  test('reference checks retain every existing readiness requirement', () {
    expect(ProductionReadinessService.isReady(fixture), isTrue,
      reason: 'Synthetic predicate fixture only; not actual acceptance evidence');
    for (final incomplete in [fixture.copyWith(isRenderOk: false),
      fixture.copyWith(isAccessibilityVerified: false),
      fixture.copyWith(isPerformanceVerified: false), fixture.copyWith(testPassRate: 94),
      fixture.copyWith(isMobileVerified: false), fixture.copyWith(isDesktopVerified: false),
      fixture.copyWith(testPassRate: double.nan), fixture.copyWith(testPassRate: double.infinity),
      fixture.copyWith(testPassRate: 101),
      fixture.copyWith(isLocalizationReady: false), fixture.copyWith(isPhiCompliant: false),
      fixture.copyWith(lifecycleStatus: LifecycleStatus.design)]) {
      expect(ProductionReadinessService.isReady(incomplete), isFalse);
    }
  });

  test('device findings and readiness agree without manufacturing verification', () {
    for (final mobile in [false, true]) {
      for (final desktop in [false, true]) {
        final screen = fixture.copyWith(deploymentEnvironment: 'production',
          isMobileVerified: mobile, isDesktopVerified: desktop);
        final before = screen.toJson();
        final blockers = ProductionReadinessService.readinessBlockers(screen);
        expect(blockers.contains('mobile-unverified'), !mobile);
        expect(blockers.contains('desktop-unverified'), !desktop);
        expect(ProductionReadinessService.isReady(screen), mobile && desktop);
        expect(ProductionReadinessService.scan(screen).any((issue) =>
          issue.id.startsWith('prod_missing_device_verif_')), !mobile || !desktop);
        expect(screen.toJson(), before);
      }
    }
  });

  test('compliance findings cannot offer a boolean auto-fix as evidence', () {
    final screen = fixture.copyWith(deploymentEnvironment: 'production',
      securityLevel: SecurityTier.high, isPhiCompliant: false,
      hasUnsavedChangeGuard: false, isLocalizationReady: false);
    final issues = [...SecurityAuditService.scan(screen),
      ...ProductionReadinessService.scan(screen)];
    for (final issue in issues.where((issue) =>
      issue.id.startsWith('security_phi_') || issue.id.startsWith('security_missing_guard_') ||
      issue.id.startsWith('prod_missing_i18n_'))) {
      expect(issue.autoRemediable, isFalse);
      expect(issue.metadata.containsKey('fixProperty'), isFalse);
    }
    expect(issues.any((issue) => issue.id.startsWith('security_phi_')), isTrue);
    expect(issues.any((issue) => issue.id.startsWith('prod_missing_i18n_')), isTrue);
  });
}
