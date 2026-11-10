import 'package:flutter_core/flutter_core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:primecare_governance/governance/widgets/platform_readiness_viewer.dart';
import 'package:primecare_governance/governance/widgets/platform_readiness_viewer_controller.dart';
import 'support/governance_test_app.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  setUpAll(initializeGovernanceTestApp);
  const fixture = ScreenMetadata(id: 'READINESS_FIXTURE', title: 'Fixture',
    route: '/fixture', roles: ['fixture']);

  test('readiness snapshot reports missing evidence without modifying records', () {
    final before = fixture.toJson();
    final snapshot = PlatformReadinessSnapshot.fromScreens({fixture.id: fixture});
    expect(snapshot.report.totalScreens, 1);
    expect(snapshot.report.productionReadyScreens, 0);
    expect(snapshot.report.blockedScreens, 1);
    expect(snapshot.pendingEvidence[fixture.id], contains('render-unverified'));
    expect(snapshot.pendingEvidence[fixture.id], contains('review-reference-missing-or-placeholder'));
    expect(fixture.toJson(), before);
  });

  test('snapshot is immutable and a new snapshot reflects changed source', () {
    final source = {fixture.id: fixture};
    final first = PlatformReadinessSnapshot.fromScreens(source);
    source.clear();
    expect(first.screens.length, 1);
    expect(() => first.screens.clear(), throwsUnsupportedError);
    expect(() => first.pendingEvidence[fixture.id]!.clear(), throwsUnsupportedError);
    expect(PlatformReadinessSnapshot.fromScreens(source).report.totalScreens, 0);
  });

  testWidgets('viewer shows actual pending evidence instead of manufactured success', (tester) async {
    final snapshot = PlatformReadinessSnapshot.fromScreens({fixture.id: fixture});
    await tester.pumpWidget(ProviderScope(overrides: [
      platformReadinessViewerControllerProvider.overrideWithValue(snapshot),
    ], child: governanceTestApp(const PlatformReadinessViewer())));
    await tester.pumpAndSettle();
    await tester.scrollUntilVisible(
      find.byKey(const ValueKey('readiness-READINESS_FIXTURE')), 300,
      scrollable: find.byType(Scrollable).first);
    expect(find.text(fixture.id), findsOneWidget);
    expect(find.textContaining('render-unverified'), findsOneWidget);
    expect(find.byIcon(Icons.pending_outlined), findsOneWidget);
    expect(find.textContaining('fully implemented'), findsNothing);
    expect(tester.takeException(), isNull);
  });

  testWidgets('empty inventory never renders an all-ready state', (tester) async {
    await tester.pumpWidget(ProviderScope(overrides: [
      platformReadinessViewerControllerProvider.overrideWithValue(
        PlatformReadinessSnapshot.fromScreens({})),
    ], child: governanceTestApp(const PlatformReadinessViewer())));
    await tester.pumpAndSettle();
    expect(find.byIcon(Icons.check_circle_outline), findsNothing);
    expect(find.byIcon(Icons.pending_outlined), findsNothing);
    expect(find.textContaining('fully implemented'), findsNothing);
    expect(tester.takeException(), isNull);
  });
}
