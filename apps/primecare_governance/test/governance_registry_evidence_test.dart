import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:primecare_governance/core/governance/registries/core_governance_registry.dart';
import 'package:primecare_governance/core/governance/registries/invalid_registry_placeholders.dart';
import 'package:primecare_ui/src/registry/screen_registry.dart' as ui;
import 'package:primecare_ui/src/features/workspace/workspace_routes_generated.dart';

void main() {
  test('registration preserves source evidence instead of fabricating readiness', () {
    PlatformScreenRegistry.clearRegistry();
    CoreGovernanceRegistry.registerScreens();
    expect(CoreGovernanceRegistry.screens.values.any(
      (screen) => !screen.isRenderOk || screen.testPassRate < 100), isTrue);
    expect({...PlatformScreenRegistry.screens.keys,
      ...CoreGovernanceRegistry.unresolvedMetadata.keys, ...CoreGovernanceRegistry.retiredMetadata.keys},
      CoreGovernanceRegistry.screens.keys.toSet(), reason: 'No source records are discarded');
    for (final source in CoreGovernanceRegistry.screens.values) {
      if (CoreGovernanceRegistry.retiredMetadata.containsKey(source.id)) {
        expect(PlatformScreenRegistry.getById(source.id), isNull);
        expect(CoreGovernanceRegistry.retiredMetadata[source.id]!.toJson(), source.toJson());
        continue;
      }
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
    expect(CoreGovernanceRegistry.retiredMetadata[unresolved.id]!.toJson(), unresolved.toJson());
  });


  test('only exact known invalid declarations retire; changed evidence remains unresolved', () {
    final id = InvalidRegistryPlaceholders.ids.first;
    final original = CoreGovernanceRegistry.screens[id]!;
    expect(InvalidRegistryPlaceholders.matches(original), isTrue);
    expect(InvalidRegistryPlaceholders.matches(original.copyWith(title: 'New requirement')), isFalse);
    expect(InvalidRegistryPlaceholders.matches(original.copyWith(roles: ['new-role'])), isFalse);
    final changed = original.copyWith(testPassRate: 37.5);
    CoreGovernanceRegistry.screens[id] = changed;
    addTearDown(() => CoreGovernanceRegistry.screens[id] = original);
    PlatformScreenRegistry.clearRegistry();
    CoreGovernanceRegistry.registerScreens();
    expect(CoreGovernanceRegistry.retiredMetadata.containsKey(id), isFalse);
    expect(CoreGovernanceRegistry.unresolvedMetadata[id]!.testPassRate, 37.5);
    expect(PlatformScreenRegistry.getById(id), isNull);
  });


  test('retired declarations have no widget binding or workspace identity', () {
    PlatformScreenRegistry.clearRegistry();
    CoreGovernanceRegistry.registerScreens();
    for (final record in CoreGovernanceRegistry.retiredMetadata.values) {
      expect(ui.ScreenRegistry.getWidget(record.id), isA<ui.ScreenNotImplementedView>());
      final ids = {record.id.toLowerCase(), record.id.replaceFirst('SCREEN_', '').toLowerCase()};
      expect(governedWorkspaceRoutes.values.any((code) => ids.contains(code.toLowerCase())), isFalse);
    }
    expect(() => CoreGovernanceRegistry.retiredMetadata.clear(), throwsUnsupportedError);
  });

}
