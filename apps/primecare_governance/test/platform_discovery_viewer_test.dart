import 'package:flutter_core/flutter_core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:primecare_governance/governance/widgets/platform_discovery_viewer.dart';
import 'package:primecare_governance/governance/widgets/platform_discovery_viewer_controller.dart';
import 'support/governance_test_app.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  setUpAll(initializeGovernanceTestApp);

  test('discovery snapshots reject invalid observations and freeze valid data', () {
    final source = <String, dynamic>{'fixture-service': 'degraded'};
    final snapshot = PlatformDiscoverySnapshot.fromObservation(available: true, services: source);
    source.clear();
    expect(snapshot.services['fixture-service'], 'degraded');
    expect(() => snapshot.services.clear(), throwsUnsupportedError);
    expect(PlatformDiscoverySnapshot.fromObservation(available: true,
      services: {'fixture-service': 42}).available, isFalse);
  });

  testWidgets('disconnected viewer cannot display stale healthy services', (tester) async {
    await tester.pumpWidget(ProviderScope(overrides: [
      platformDiscoveryViewerControllerProvider.overrideWithValue(
        PlatformDiscoverySnapshot.fromObservation(available: false,
          services: {'stale-service': 'healthy'})),
    ], child: governanceTestApp(const PlatformDiscoveryViewer())));
    await tester.pumpAndSettle();
    expect(find.text('stale-service'), findsNothing);
    expect(find.byIcon(Icons.check_circle_outline), findsNothing);
    expect(find.textContaining('fully implemented'), findsNothing);
    expect(tester.takeException(), isNull);
  });

  testWidgets('viewer renders observed service status without manufacturing health', (tester) async {
    await tester.pumpWidget(ProviderScope(overrides: [
      platformDiscoveryViewerControllerProvider.overrideWithValue(
        PlatformDiscoverySnapshot.fromObservation(available: true,
          services: {'fixture-service': 'degraded'})),
    ], child: governanceTestApp(const PlatformDiscoveryViewer())));
    await tester.pumpAndSettle();
    expect(find.text('fixture-service'), findsOneWidget);
    expect(find.text('degraded'), findsOneWidget);
    expect(find.byIcon(Icons.check_circle_outline), findsNothing);
    expect(find.textContaining('fully implemented'), findsNothing);
    expect(tester.takeException(), isNull);
  });

  testWidgets('empty observation is not an all-healthy result', (tester) async {
    await tester.pumpWidget(ProviderScope(overrides: [
      platformDiscoveryViewerControllerProvider.overrideWithValue(
        PlatformDiscoverySnapshot.fromObservation(available: true, services: {})),
    ], child: governanceTestApp(const PlatformDiscoveryViewer())));
    await tester.pumpAndSettle();
    expect(find.byType(ListTile), findsNothing);
    expect(find.byIcon(Icons.check_circle_outline), findsNothing);
    expect(tester.takeException(), isNull);
  });
}
