import 'package:primecare_core/primecare_core.dart';
import 'package:test/test.dart';

class Dashboard extends BaseDashboardServiceWorkflow {}

class Scheduler extends BaseSchedulerServiceWorkflow {}

class Psw extends BasePswServiceWorkflow<Transport> {
  Psw(super.api);
}

class Transport implements BaseApiTransport {
  dynamic data = <String, dynamic>{};
  Object? error;
  final paths = <String>[];
  @override
  Future<ApiResponse> get(
    String path, {
    Map<String, dynamic>? queryParameters,
  }) async {
    paths.add(path);
    if (error != null) throw error!;
    return ApiResponse(data: data, statusCode: 200);
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => throw UnimplementedError();
}

class Gates extends BaseExecutionGateService {
  final logs = <String>[];
  @override
  void log(String message) => logs.add(message);
}

void main() {
  test(
    'PSW routes decoding and transport errors retain all three workflows',
    () async {
      final transport = Transport();
      final service = Psw(transport);
      expect((await service.getDashboardData()).getOrThrow().shiftProgress, 0);
      transport.data = <dynamic>[
        <String, dynamic>{'id': 'client', 'name': 'Patient'},
      ];
      expect((await service.getClients()).getOrThrow().single.id, 'client');
      transport.data = <dynamic>[
        <String, dynamic>{'id': 'task', 'title': 'Visit'},
      ];
      expect((await service.getTasks()).getOrThrow().single.title, 'Visit');
      expect(transport.paths, ['/psw/dashboard', '/psw/clients', '/psw/tasks']);
      final error = StateError('offline');
      transport.error = error;
      expect(
        (await service.getDashboardData() as Failure<PswDashboardData>).error,
        same(error),
      );
      expect(
        (await service.getClients() as Failure<List<PswClient>>).error,
        same(error),
      );
      expect(
        (await service.getTasks() as Failure<List<PswTask>>).error,
        same(error),
      );
    },
  );
  test('PSW malformed payload still becomes guarded failure', () async {
    final transport = Transport()..data = 'invalid';
    final service = Psw(transport);
    expect(await service.getDashboardData(), isA<Failure<PswDashboardData>>());
    expect(await service.getClients(), isA<Failure<List<PswClient>>>());
    expect(await service.getTasks(), isA<Failure<List<PswTask>>>());
  });
  test(
    'dashboard keeps existing synthetic metrics and empty AI forecast',
    () async {
      final service = Dashboard();
      final metrics = (await service.getMetrics('Support')).getOrThrow();
      expect(metrics, isA<DashboardMetrics>());
      expect(
        (await service.getClinicalIntelligence('ignored')).getOrThrow(),
        isA<ClinicalIntelligenceViewModel>(),
      );
      final ai = (await service.getAIAnalyticsForecasting()).getOrThrow();
      expect(ai.predictedTrends, isEmpty);
      expect(ai.recommendations, isEmpty);
    },
  );
  test(
    'scheduler retains bootstrap conflict failure and simulated mutations',
    () async {
      final service = Scheduler();
      final gates = Gates();
      service.attachTelemetry(gates);
      final schedule = (await service.getHorizonSchedule()).getOrThrow();
      expect(schedule.appointments, isNotEmpty);
      expect(
        await service.createAppointment(schedule.appointments.first),
        isA<Failure<void>>(),
      );
      expect(
        await service.updateAppointment(schedule.appointments.first),
        isA<Success<void>>(),
      );
      expect(await service.deleteAppointment('missing'), isA<Success<void>>());
      expect(
        gates.logs.any((s) => s.contains('Failed to create appointment')),
        isTrue,
      );
      expect(
        gates.logs.any((s) => s.contains('Appointment updated successfully')),
        isTrue,
      );
    },
  );
}
