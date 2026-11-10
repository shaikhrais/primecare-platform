import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:primecare_governance/core/governance/registries/core_governance_registry.dart';

void main() {
  test('registration preserves source evidence instead of fabricating readiness', () {
    PlatformScreenRegistry.clearRegistry();
    CoreGovernanceRegistry.registerScreens();
    expect(CoreGovernanceRegistry.screens.values.any(
      (screen) => !screen.isRenderOk || screen.testPassRate < 100), isTrue);
    for (final source in CoreGovernanceRegistry.screens.values) {
      final expected = source.routePath.isEmpty
          ? source.copyWith(route: '/reconciled/${source.id.toLowerCase()}') : source;
      expect(PlatformScreenRegistry.getById(source.id)!.toJson(), expected.toJson(),
        reason: '${source.id}: registration must preserve recorded evidence and roles');
    }
  });

  test('route normalization preserves unrelated partial and unverified evidence', () {
    PlatformScreenRegistry.clearRegistry();
    const source = ScreenMetadata(id: 'FIXTURE_PARTIAL', title: 'Fixture',
      testPassRate: 37.5, testScenarioCount: 8,
      lifecycleStatus: LifecycleStatus.design,
      isRenderOk: false, userApprovedLayout: false,
      uatApprover: 'none', lastVerificationHash: 'HASH_PENDING');
    PlatformScreenRegistry.registerScreens([source]);
    CoreGovernanceRegistry.registerScreens();
    final actual = PlatformScreenRegistry.getById(source.id)!;
    expect(actual.toJson(), source.copyWith(route: '/reconciled/fixture_partial').toJson());
    expect(actual.testPassRate, 37.5);
    expect(actual.uatApprover, 'none');
    expect(actual.isSecurityVerified, isFalse);
    expect(actual.isAccessibilityVerified, isFalse);
    expect(actual.lastVerificationHash, 'HASH_PENDING');
  });
}
