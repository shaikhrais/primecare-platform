import 'package:primecare_core/primecare_core.dart';
import 'package:test/test.dart';

class Transport implements BaseApiTransport {
  ApiResponse response = ApiResponse(
    data: {
      'data': {'ok': true},
    },
    statusCode: 200,
  );
  Object? error;
  final calls = <(String, String, dynamic)>[];
  Future<ApiResponse> request(String method, String path, dynamic body) async {
    calls.add((method, path, body));
    if (error != null) throw error!;
    return response;
  }

  @override
  Future<ApiResponse> get(
    String path, {
    Map<String, dynamic>? queryParameters,
  }) => request('GET', path, queryParameters);
  @override
  Future<ApiResponse> post(String path, {dynamic body}) =>
      request('POST', path, body);
  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class Repository extends BaseTransportRepository<Transport> {
  Repository(super.client);
}

class Gates extends BaseExecutionGateService {
  final logs = <String>[];
  @override
  void log(String message) => logs.add(message);
}

class Domain extends BaseDomainServiceWorkflow<Repository, Gates> {
  Domain(super.repository, super.telemetry, super.endpoints);
}

class Profiles extends BaseProviderServiceWorkflow<Repository, Gates> {
  Profiles(super.repository, super.telemetry, super.endpoints);
}

class Reports extends BaseReportServiceWorkflow<Repository, Gates> {
  Reports(super.repository, super.telemetry, super.endpoints);
}

class Verification extends BaseVerificationServiceWorkflow<Repository, Gates> {
  Verification(super.repository, super.telemetry, super.endpoints);
}

void main() {
  test(
    'domain routes verbs body identities and recovery across complete family',
    () async {
      final transport = Transport();
      final repo = Repository(transport);
      final gates = Gates();
      final endpoints = {
        for (final key in [
          'intakeCases',
          'carePlansUpdate',
          'trainingDirectorView',
          'trainingComplete',
          'supportEscalate',
          'franchiseTerritoryUpdate',
          'reportingSummary',
          'adminStaffProvision',
          'adminAuditOverride',
          'officePartnershipLeadsView',
          'providerMetrics',
        ])
          key: '/$key',
      };
      final service = Domain(repo, gates, endpoints);
      final body = <String, dynamic>{'id': 'case'};
      final cases =
          <(String, String, Future<Result<DomainResponse>> Function())>[
            ('POST', '/intakeCases', () => service.openCase(body)),
            ('POST', '/carePlansUpdate', () => service.updateCarePlan(body)),
            ('GET', '/trainingDirectorView', service.getTrainingMetrics),
            (
              'POST',
              '/trainingComplete',
              () => service.completeTrainingCourse(body),
            ),
            ('POST', '/supportEscalate', () => service.escalateTicket(body)),
            (
              'POST',
              '/franchiseTerritoryUpdate',
              () => service.updateTerritory(body),
            ),
            ('GET', '/reportingSummary', service.getReportingSummary),
            (
              'POST',
              '/adminStaffProvision',
              () => service.provisionStaff(body),
            ),
            (
              'POST',
              '/adminAuditOverride',
              () => service.requestAuditOverride(body),
            ),
            ('GET', '/officePartnershipLeadsView', service.getPartnershipData),
            (
              'GET',
              '/api/training-coordinator/dashboard',
              service.getCoordinationMetrics,
            ),
            (
              'GET',
              '/providerMetrics?route=Support',
              service.getSupportMetrics,
            ),
            (
              'GET',
              '/providerMetrics?route=Clinical',
              () => service.getDomainMetrics('Clinical'),
            ),
          ];
      for (final (method, path, run) in cases) {
        expect((await run()).getOrThrow().data, {'ok': true});
        expect(transport.calls.last.$1, method);
        expect(transport.calls.last.$2, path);
        if (method == 'POST') expect(transport.calls.last.$3, same(body));
        transport.error = StateError('offline');
        expect((await run()).getOrThrow().success, isFalse);
        transport.error = null;
      }
      endpoints['trainingCoordinatorDashboard'] = '/configured';
      await service.getCoordinationMetrics();
      expect(transport.calls.last.$2, '/configured');
      expect(service.repository, same(repo));
      expect(service.telemetry, same(gates));
    },
  );
  test(
    'provider strict envelope and check-in preserve failure policies',
    () async {
      final t = Transport();
      final service = Profiles(Repository(t), Gates(), {
        'providerProfile': '/profile',
        'providerCheckin': '/visits/:visitId/checkin',
      });
      t.response = ApiResponse(
        statusCode: 200,
        data: {
          'profile': {
            'id': 'p',
            'full_name': 'Provider',
            'bio': null,
            'languages': 'English',
            'service_areas': 'Hamilton',
            'provider_type': 'PSW',
            'is_approved': true,
            'skills': '',
          },
        },
      );
      expect((await service.getSelfProfile()).getOrThrow().id, 'p');
      t.response = ApiResponse(statusCode: 403, data: <String, dynamic>{});
      expect(await service.getSelfProfile(), isA<Failure<ProviderProfile>>());
      await service.logCheckIn('v', 1, 2);
      expect(t.calls.last.$2, '/visits/v/checkin');
      final checkIn = t.calls.last.$3 as Map<String, dynamic>;
      expect(checkIn['lat'], 1);
      expect(checkIn['lng'], 2);
      expect(DateTime.tryParse(checkIn['timestamp'] as String), isNotNull);
      final error = StateError('offline');
      t.error = error;
      expect(
        (await service.getSelfProfile() as Failure<ProviderProfile>).error,
        same(error),
      );
      expect(await service.logCheckIn('v', 1, 2), isA<Success<void>>());
    },
  );
  test(
    'reports preserve success status fallback and transport recovery',
    () async {
      final t = Transport();
      final service = Reports(Repository(t), Gates(), {});
      t.response = ApiResponse(
        statusCode: 200,
        data: {
          'id': 'r',
          'title': 'Report',
          'columns': <dynamic>[],
          'rows': <dynamic>[],
        },
      );
      expect((await service.getReport('r')).getOrThrow().title, 'Report');
      expect(t.calls.last.$2, '/api/reports/r');
      t.response = ApiResponse(statusCode: 404, data: <String, dynamic>{});
      expect(
        (await service.getReport('r')).getOrThrow().title,
        'Report Load Failure (404)',
      );
      t.error = StateError('offline');
      expect((await service.getReport('r')).getOrThrow().isOffline, isTrue);
    },
  );
  test('verification reports retain maps and empty recovery', () async {
    final t = Transport();
    final service = Verification(Repository(t), Gates(), {
      'verificationPurposeReport': '/purpose',
      'verificationDatabaseReport': '/database',
    });
    final data = <String, dynamic>{'healthy': true};
    t.response = ApiResponse(statusCode: 200, data: data);
    for (final run in [
      service.getArchitecturePurposeReport,
      service.getDatabaseReport,
    ]) {
      expect((await run()).getOrThrow(), same(data));
      t.response = ApiResponse(statusCode: 500, data: <String, dynamic>{});
      expect((await run()).getOrThrow(), isEmpty);
      t.error = StateError('offline');
      expect((await run()).getOrThrow(), isEmpty);
      t.error = null;
      t.response = ApiResponse(statusCode: 200, data: data);
    }
  });
}
