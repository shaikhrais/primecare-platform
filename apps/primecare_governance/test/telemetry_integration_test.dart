// Governance - Category: test | Purpose: Core implementation file for the Telemetry Integration Test platform logic.
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_governance/core/governance/governance_provider.dart';
import 'package:primecare_governance/core/governance/governance_api_service.dart';
import 'package:primecare_governance/governance/services/governance_history_service.dart';
import 'package:primecare_governance/governance/services/history_provider.dart';
import 'package:mocktail/mocktail.dart';
import 'dart:async';
import 'package:flutter_core/flutter_core.dart';
import 'package:primecare_governance/governance/models/governance_report.dart';
import 'package:primecare_governance/governance/services/network_parity_service.dart';

class MockGovernanceApiService extends Mock implements GovernanceApiService {}

class MockGovernanceHistoryService extends Mock
    implements GovernanceHistoryService {}

class FakeTelemetryReport extends Fake implements GovernanceReport {}

class FixtureParityService extends NetworkParityService {
  FixtureParityService() : super(baseUrl: 'https://fixture.invalid');
  Future<List<PlatformAuditIssue>> Function() audit = () async => [];
  Future<List<Map<String, dynamic>>> Function() events = () async => [];
  @override
  Future<List<PlatformAuditIssue>> fetchBackendAudit() => audit();
  @override
  Future<List<Map<String, dynamic>>> fetchTelemetry() => events();
}

void main() {
  setUpAll(() => registerFallbackValue(FakeTelemetryReport()));
  TestWidgetsFlutterBinding.ensureInitialized();
  group('Governance Telemetry Integration', () {
    late MockGovernanceApiService mockApiService;
    late MockGovernanceHistoryService mockHistoryService;
    late FixtureParityService parity;
    late StreamController<Map<String, dynamic>> telemetryController;

    setUp(() {
      parity = FixtureParityService();
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
      when(() => mockHistoryService.captureSnapshot(any())).thenAnswer((_) async {});
    });

    tearDown(() {
      telemetryController.close();
    });

    ProviderContainer makeContainer({GovernanceApiService? api, bool disposeAtEnd = true}) {
      final container = ProviderContainer(overrides: [
        governanceApiServiceProvider.overrideWithValue(api ?? mockApiService),
        networkParityServiceProvider.overrideWithValue(parity),
        governanceHistoryServiceProvider.overrideWithValue(mockHistoryService),
      ]);
      if (disposeAtEnd) addTearDown(container.dispose);
      container.read(governanceProvider);
      return container;
    }

    final valid = <String, dynamic>{'api_uptime': 99.5, 'db_connections': 7,
      'service_health': {'fixture-service': 'healthy'}};

    test('unobserved operational status never claims working auth or complete intake', () {
      final state = makeContainer().read(governanceProvider);
      expect(state.runtimeAuditAvailable, isFalse);
      expect(state.isLoginWorking, isNull);
      expect(state.isLogoutWorking, isNull);
      expect(state.isTokenValid, isNull);
      expect(state.intakeReadinessScore, isNull);
      expect(state.pendingProposalsCount, isNull);
      expect(state.approvedProposalsCount, isNull);
      expect(state.deployedProposalsCount, isNull);
      expect(state.workingRoutes, 0);
      expect(state.workingApis, 0);
      expect(state.failedApis, 0);
      final previouslyObserved = state.copyWith(isLoginWorking: true,
        intakeReadinessScore: 100.0, pendingProposalsCount: 3);
      final unavailable = previouslyObserved.copyWith(isLoginWorking: null,
        intakeReadinessScore: null, pendingProposalsCount: null);
      expect(unavailable.isLoginWorking, isNull);
      expect(unavailable.intakeReadinessScore, isNull);
      expect(unavailable.pendingProposalsCount, isNull);
    });

    test('manual refresh never replaces invalid remote timestamps with current time', () async {
      final container = makeContainer();
      for (final timestamp in [null, '', 'not-a-time', '2026-11-10', '2026-11-10T12:00:00']) {
        telemetryController.add(valid);
        parity.events = () async => [{'type': 'fixture-remote', 'message': 'invalid',
          'level': 'info', 'timestamp': timestamp}];
        await container.read(governanceProvider.notifier).refresh();
        final state = container.read(governanceProvider);
        expect(state.recentEvents.where((e) => e.type == 'fixture-remote'), isEmpty);
        expect(state.telemetryAvailable, isFalse);
        expect(state.liveServiceHealth, isEmpty);
        expect(state.isSyncing, isFalse);
      }
    });

    test('valid refresh events retain their actual timestamp across later stream frames', () async {
      final container = makeContainer();
      parity.events = () async => [{'type': 'fixture-remote', 'message': 'observed',
        'level': 'info', 'timestamp': '2026-11-10T12:00:00Z'}];
      await container.read(governanceProvider.notifier).refresh();
      telemetryController.add(valid);
      final observed = container.read(governanceProvider).recentEvents
        .singleWhere((e) => e.type == 'fixture-remote');
      expect(observed.timestamp, DateTime.utc(2026, 11, 10, 12));
    });

    for (final failOlder in [false, true]) {
      test('older refresh ${failOlder ? 'failure' : 'success'} cannot overwrite newer findings', () async {
        final container = makeContainer();
        final pending = <Completer<List<PlatformAuditIssue>>>[];
        parity.audit = () {
          final completer = Completer<List<PlatformAuditIssue>>();
          pending.add(completer);
          return completer.future;
        };
        final notifier = container.read(governanceProvider.notifier);
        final old = notifier.refresh();
        final current = notifier.refresh();
        pending[1].complete([PlatformAuditIssue(id: 'new-fixture', subsystem: 'fixture', registry: 'fixture',
          issue: 'Current finding', suggestion: 'Inspect current source')]);
        await current;
        if (failOlder) pending[0].completeError(StateError('older fixture failure'));
        else pending[0].complete([PlatformAuditIssue(id: 'old-fixture', subsystem: 'fixture', registry: 'fixture',
          issue: 'Old finding', suggestion: 'Old source')]);
        await old;
        final state = container.read(governanceProvider);
        expect(state.subsystemIssues.map((i) => i.id), contains('new-fixture'));
        expect(state.subsystemIssues.map((i) => i.id), isNot(contains('old-fixture')));
        expect(state.isSyncing, isFalse);
      });
    }

    test('disposed refresh cannot publish observations or save history', () async {
      final container = makeContainer(disposeAtEnd: false);
      final pending = Completer<List<PlatformAuditIssue>>();
      parity.audit = () => pending.future;
      final work = container.read(governanceProvider.notifier).refresh();
      container.dispose();
      pending.complete([]);
      await work;
      verifyNever(() => mockHistoryService.captureSnapshot(any()));
    });

    test('current refresh failure clears stale live health without a success receipt', () async {
      final container = makeContainer();
      telemetryController.add(valid);
      parity.audit = () async => throw StateError('fixture unavailable');
      await container.read(governanceProvider.notifier).refresh();
      final state = container.read(governanceProvider);
      expect(state.telemetryAvailable, isFalse);
      expect(state.liveServiceHealth, isEmpty);
      expect(state.isSyncing, isFalse);
      expect(state.recentEvents.first.level, GovernanceEventLevel.error);
      verifyNever(() => mockHistoryService.captureSnapshot(any()));
    });

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
        {...valid, 'events': [{'type': 'audit', 'message': 'fixture', 'level': 'info',
          'timestamp': '2026-11-10T12:00:00'}]},
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
        final eventTime = DateTime.now().toUtc();
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
