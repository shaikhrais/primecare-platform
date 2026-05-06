import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_governance/core/governance/governance_provider.dart';
import 'package:primecare_governance/core/governance/governance_api_service.dart';
import 'package:primecare_governance/governance/services/governance_history_service.dart';
import 'package:primecare_governance/governance/services/history_provider.dart';
import 'package:primecare_governance/features/proposal_governance/providers/proposal_provider.dart';
import 'package:primecare_governance/features/proposal_governance/repositories/proposal_repository.dart';
import 'package:primecare_governance/features/proposal_governance/models/proposal_intake.dart';
import 'package:mocktail/mocktail.dart';
import 'dart:async';

class MockGovernanceApiService extends Mock implements GovernanceApiService {}
class MockGovernanceHistoryService extends Mock implements GovernanceHistoryService {}
class MockProposalRepository extends Mock implements ProposalRepository {}
class FakeProposalIntake extends Fake implements ProposalIntake {}

void main() {
  setUpAll(() {
    registerFallbackValue(FakeProposalIntake());
  });
  TestWidgetsFlutterBinding.ensureInitialized();
  group('Governance Telemetry Integration', () {
    late MockGovernanceApiService mockApiService;
    late MockGovernanceHistoryService mockHistoryService;
    late MockProposalRepository mockProposalRepo;
    late StreamController<Map<String, dynamic>> telemetryController;

    setUp(() {
      mockApiService = MockGovernanceApiService();
      mockHistoryService = MockGovernanceHistoryService();
      mockProposalRepo = MockProposalRepository();
      telemetryController = StreamController<Map<String, dynamic>>.broadcast(sync: true);
      when(() => mockApiService.telemetryStream).thenAnswer((_) => telemetryController.stream);
      when(() => mockHistoryService.getHealthTrend()).thenAnswer((_) async => []);
      when(() => mockProposalRepo.getAll()).thenAnswer((_) async => []);
      when(() => mockProposalRepo.save(any())).thenAnswer((_) async => {});
    });

    tearDown(() {
      telemetryController.close();
    });

    test('GovernanceNotifier updates state from telemetry stream events', () async {
      final container = ProviderContainer(
        overrides: [
          governanceApiServiceProvider.overrideWithValue(mockApiService),
          governanceHistoryServiceProvider.overrideWithValue(mockHistoryService),
          proposalRepositoryProvider.overrideWithValue(mockProposalRepo),
        ],
      );
      addTearDown(container.dispose);
      // Ensure proposals are loaded to prevent rebuilds during telemetry processing
      await container.read(proposalListProvider.future);
      
      // Keep provider alive
      final subscription = container.listen(governanceProvider, (_, __) {});
      addTearDown(subscription.close);

      final stream = container.read(governanceApiServiceProvider).telemetryStream;
      stream.listen((data) {});
      
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
      await Future.delayed(const Duration(milliseconds: 50));

      final state = container.read(governanceProvider);
      
      expect(state.apiUptime, 99.5);
      expect(state.dbConnections, 50);
      expect(state.recentEvents, isNotEmpty);
      expect(state.recentEvents.first.message, 'Test Security Alert');
      expect(state.recentEvents.first.level, GovernanceEventLevel.critical);
      expect(state.liveServiceHealth['auth-api'], 'healthy');
    });
  });
}
