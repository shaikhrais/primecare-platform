import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_governance/core/governance/governance_provider.dart';
import 'package:primecare_governance/core/governance/governance_api_service.dart';
import 'package:mocktail/mocktail.dart';
import 'dart:async';

class MockGovernanceApiService extends Mock implements GovernanceApiService {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  group('Governance Telemetry Integration', () {
    late MockGovernanceApiService mockApiService;
    late StreamController<Map<String, dynamic>> telemetryController;

    setUp(() {
      mockApiService = MockGovernanceApiService();
      telemetryController = StreamController<Map<String, dynamic>>.broadcast();
      when(() => mockApiService.telemetryStream).thenAnswer((_) => telemetryController.stream);
    });

    tearDown(() {
      telemetryController.close();
    });

    test('GovernanceNotifier updates state from telemetry stream events', () async {
      final container = ProviderContainer(
        overrides: [
          governanceApiServiceProvider.overrideWithValue(mockApiService),
        ],
      );
      addTearDown(container.dispose);

      // Force initialization of the provider so it starts listening
      container.read(governanceProvider);
      
      // Push initial data to ensure state is calculated
      telemetryController.add({
        'api_uptime': 100.0,
        'db_connections': 0,
        'service_health': {},
        'events': []
      });

      // Allow initialization
      await Future.delayed(Duration.zero);

      // Push target telemetry data
      final eventTime = DateTime.now();
      telemetryController.add({
        'api_uptime': 99.5,
        'db_connections': 50,
        'service_health': {'auth-api': 'healthy'},
        'events': [{
          'type': 'security',
          'message': 'Test Security Alert',
          'level': 'high',
          'timestamp': eventTime.toIso8601String(),
        }]
      });

      // Allow processing
      await Future.delayed(const Duration(milliseconds: 100));

      final state = container.read(governanceProvider);
      
      expect(state.apiUptime, 99.5);
      expect(state.dbConnections, 50);
      expect(state.recentEvents, isNotEmpty);
      expect(state.recentEvents.first.message, 'Test Security Alert');
      expect(state.recentEvents.first.level, 'high');
      expect(state.liveServiceHealth['auth-api'], 'healthy');
    });
  });
}
