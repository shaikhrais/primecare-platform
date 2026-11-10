// Governance - Category: test | Purpose: Core implementation file for the Telemetry Integration Test platform logic.
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_governance/core/governance/governance_provider.dart';
import 'package:primecare_governance/core/governance/governance_api_service.dart';
import 'package:primecare_governance/governance/services/governance_history_service.dart';
import 'package:primecare_governance/governance/services/history_provider.dart';
import 'package:mocktail/mocktail.dart';
import 'dart:async';

class MockGovernanceApiService extends Mock implements GovernanceApiService {}

class MockGovernanceHistoryService extends Mock
    implements GovernanceHistoryService {}

void main() {
  setUpAll(() {});
  TestWidgetsFlutterBinding.ensureInitialized();
  group('Governance Telemetry Integration', () {
    late MockGovernanceApiService mockApiService;
    late MockGovernanceHistoryService mockHistoryService;
    late StreamController<Map<String, dynamic>> telemetryController;

    setUp(() {
      mockApiService = MockGovernanceApiService();
      mockHistoryService = MockGovernanceHistoryService();
      telemetryController = StreamController<Map<String, dynamic>>.broadcast(
        sync: true,
      );
      when(
        () => mockApiService.telemetryStream,
      ).thenAnswer((_) => telemetryController.stream);
      when(
        () => mockHistoryService.getHealthTrend(),
      ).thenAnswer((_) async => []);
    });

    tearDown(() {
      telemetryController.close();
    });

    ProviderContainer makeContainer({GovernanceApiService? api}) {
      final container = ProviderContainer(overrides: [
        governanceApiServiceProvider.overrideWithValue(api ?? mockApiService),
        governanceHistoryServiceProvider.overrideWithValue(mockHistoryService),
      ]);
      addTearDown(container.dispose);
      container.read(governanceProvider);
      return container;
    }

    final valid = <String, dynamic>{'api_uptime': 99.5, 'db_connections': 7,
      'service_health': {'fixture-service': 'healthy'}};

    test('missing transport initializes unavailable without invented health', () async {
      final container = makeContainer(api: GovernanceApiService());
      await Future<void>.delayed(Duration.zero);
      final state = container.read(governanceProvider);
      expect(state.telemetryAvailable, isFalse);
      expect(state.apiUptime, 0);
      expect(state.dbConnections, 0);
      expect(state.liveServiceHealth, isEmpty);
      expect(state.recentEvents, isEmpty);
    });

    test('telemetry errors clear stale health and valid frames can recover', () async {
      final container = makeContainer();
      telemetryController.add(valid);
      expect(container.read(governanceProvider).telemetryAvailable, isTrue);
      telemetryController.addError(StateError('fixture disconnect'));
      final failed = container.read(governanceProvider);
      expect(failed.telemetryAvailable, isFalse);
      expect(failed.liveServiceHealth, isEmpty);
      expect(failed.apiUptime, 0);
      expect(failed.dbConnections, 0);
      telemetryController.add(valid);
      expect(container.read(governanceProvider).telemetryAvailable, isTrue);
      expect(container.read(governanceProvider).liveServiceHealth['fixture-service'], 'healthy');
    });

    test('closed telemetry stream cannot leave services marked healthy', () async {
      final container = makeContainer();
      telemetryController.add(valid);
      await telemetryController.close();
      expect(container.read(governanceProvider).telemetryAvailable, isFalse);
      expect(container.read(governanceProvider).liveServiceHealth, isEmpty);
    });

    test('invalid telemetry cannot fabricate measurements or event timestamps', () async {
      final container = makeContainer();
      for (final invalid in [
        {...valid, 'api_uptime': double.nan}, {...valid, 'api_uptime': double.infinity},
        {...valid, 'api_uptime': 101}, {...valid, 'db_connections': -1},
        {...valid, 'service_health': {'fixture-service': true}},
        {...valid, 'events': [{'type': 'audit', 'message': 'fixture', 'level': 'info',
          'timestamp': 'not-a-timestamp'}]},
      ]) {
        telemetryController.add(valid);
        telemetryController.add(invalid);
        final state = container.read(governanceProvider);
        expect(state.telemetryAvailable, isFalse);
        expect(state.liveServiceHealth, isEmpty);
        expect(state.recentEvents, isEmpty);
      }
    });

    test(
      'GovernanceNotifier updates state from telemetry stream events',
      () async {
        final container = ProviderContainer(
          overrides: [
            governanceApiServiceProvider.overrideWithValue(mockApiService),
            governanceHistoryServiceProvider.overrideWithValue(
              mockHistoryService,
            ),
          ],
        );
        addTearDown(container.dispose);

        // Keep provider alive
        final subscription = container.listen(governanceProvider, (_, next) {});
        addTearDown(subscription.close);

        final stream = container
            .read(governanceApiServiceProvider)
            .telemetryStream;
        stream.listen((data) {});

        // Allow initialization
        await Future<void>.delayed(Duration.zero);

        // Push target telemetry data
        final eventTime = DateTime.now();
        telemetryController.add({
          'api_uptime': 99.5,
          'db_connections': 50,
          'service_health': {'auth-api': 'healthy'},
          'events': [
            {
              'type': 'security',
              'message': 'Test Security Alert',
              'level': 'high',
              'timestamp': eventTime.toIso8601String(),
            },
          ],
        });

        // Allow processing
        await Future<void>.delayed(const Duration(milliseconds: 50));

        final state = container.read(governanceProvider);

        expect(state.apiUptime, 99.5);
        expect(state.dbConnections, 50);
        expect(state.recentEvents, isNotEmpty);
        expect(state.recentEvents.first.message, 'Test Security Alert');
        expect(state.recentEvents.first.level, GovernanceEventLevel.critical);
        expect(state.liveServiceHealth['auth-api'], 'healthy');
      },
    );
  });
}
