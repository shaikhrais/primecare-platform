import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:primecare_governance/core/governance/registries/core_governance_registry.dart';

void main() {
  test('registration preserves source evidence instead of fabricating readiness', () {
    PlatformScreenRegistry.clearRegistry();
    CoreGovernanceRegistry.registerScreens();
    expect(CoreGovernanceRegistry.screens.values.any(
      (screen) => !screen.isRenderOk || screen.testPassRate < 100), isTrue);
    expect({...PlatformScreenRegistry.screens.keys,
      ...CoreGovernanceRegistry.unresolvedMetadata.keys},
      CoreGovernanceRegistry.screens.keys.toSet(), reason: 'No source records are discarded');
    for (final source in CoreGovernanceRegistry.screens.values) {
      if (CoreGovernanceRegistry.unresolvedMetadata.containsKey(source.id)) {
        expect(PlatformScreenRegistry.getById(source.id), isNull);
        expect(CoreGovernanceRegistry.unresolvedMetadata[source.id]!.toJson(), source.toJson());
        continue;
      }
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

  test('blank records remain auditable and never acquire routes or administrator access', () {
    PlatformScreenRegistry.clearRegistry();
    const unresolved = ScreenMetadata(id: 'FIXTURE_UNRESOLVED', title: '');
    PlatformScreenRegistry.registerScreens([unresolved]);
    CoreGovernanceRegistry.registerScreens();
    expect(PlatformScreenRegistry.getById(unresolved.id), isNull);
    final retained = CoreGovernanceRegistry.unresolvedMetadata[unresolved.id]!;
    expect(retained.toJson(), unresolved.toJson());
    expect(retained.routePath, isEmpty);
    expect(retained.allowedRoles, isEmpty);
    expect(retained.lastVerificationHash, 'HASH_PENDING');
    expect(() => CoreGovernanceRegistry.unresolvedMetadata.clear(), throwsUnsupportedError);
  });


  test('previous fabricated routes and administrator roles cannot revive an unresolved source record', () {
    PlatformScreenRegistry.clearRegistry();
    final unresolved = CoreGovernanceRegistry.screens.values.firstWhere((screen) =>
      screen.title.isEmpty && screen.featureName.isEmpty && screen.routePath.isEmpty &&
      screen.allowedRoles.isEmpty);
    PlatformScreenRegistry.registerScreens([
      unresolved.copyWith(route: '/invented-fixture', roles: ['ADMIN'], testPassRate: 100),
    ]);
    CoreGovernanceRegistry.registerScreens();
    expect(PlatformScreenRegistry.getById(unresolved.id), isNull);
    expect(CoreGovernanceRegistry.unresolvedMetadata[unresolved.id]!.toJson(), unresolved.toJson());
  });

}
