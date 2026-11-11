import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:primecare_governance/core/governance/governance_provider.dart';
import 'package:primecare_governance/core/governance/registries/index.dart';
import 'package:primecare_governance/governance/services/governance_history_service.dart';
import 'package:primecare_governance/governance/services/history_provider.dart';
import 'package:primecare_governance/governance/models/governance_report.dart';
import 'package:mocktail/mocktail.dart';

class MockGovernanceHistoryService extends Mock implements GovernanceHistoryService {}
class FakeGovernanceReport extends Fake implements GovernanceReport {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  setUpAll(() => registerFallbackValue(FakeGovernanceReport()));

  test('blueprint hydration audits without creating registrations or completion credit', () async {
    final history = MockGovernanceHistoryService();
    when(() => history.getHealthTrend()).thenAnswer((_) async => []);
    when(() => history.captureSnapshot(any())).thenAnswer((_) async {});
    Registry.registerAll();
    final container = ProviderContainer(overrides: [
      governanceHistoryServiceProvider.overrideWithValue(history),
    ]);
    addTearDown(container.dispose);
    final notifier = container.read(governanceProvider.notifier);
    final before = {for (final e in PlatformScreenRegistry.screens.entries) e.key: e.value.toJson()};
    await notifier.hydrateRegistries();
    expect({for (final e in PlatformScreenRegistry.screens.entries) e.key: e.value.toJson()}, before);
    final state = container.read(governanceProvider);
    expect(state.isSyncing, isFalse);
    expect(state.recentEvents.where((e) => e.type == 'Hydrator').single.level,
      GovernanceEventLevel.warning);
    expect(state.recentEvents.any((e) => e.message.contains('Hydration Complete')), isFalse);
    verifyNever(() => history.captureSnapshot(any()));
  });
}
