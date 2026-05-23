// Governance - Category: test | Purpose: Core implementation file for the Telemetry Integration Test platform logic.
﻿import 'package:flutter_test/flutter_test.dart';
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
