import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_core/business_core.dart';
import 'package:flutter_core/src/repositories/own_notifications_repository.dart';
import 'package:flutter_core/models/domain_response.dart';
import 'package:flutter_core/src/models/scheduler_models.dart';
import 'package:flutter_core/src/network/api_client.dart';
import 'package:flutter_core/src/resilience/execution_gate_service.dart';
import 'package:flutter_core/src/resilience/result.dart';

class NarrowRepositoryFake implements OwnNotificationsRepository {
  @override
  Future<ApiResponse> load() async => ApiResponse(
    data: <String, dynamic>{},
    statusCode: 401,
    error: 'Session expired',
  );
}

class FixtureService extends BaseBusinessService {
  FixtureService(super.client, super.telemetry);
  Future<Result<int>> compute({bool rethrowError = false}) => guard<int>(
    () => throw StateError('unavailable'),
    onError: (error, stack) {
      if (rethrowError) Error.throwWithStackTrace(error, stack);
      return 7;
    },
  );
}

class FixturePolicy extends BasePermissionPolicy {
  final updates = <Map<String, List<String>>>[];
  @override
  String get cacheKey => 'fixture_permissions';
  @override
  String get endpoint => '/fixture/permissions';
  @override
  Map<String, List<String>> get fallbackPermissions => {
    'guest': ['existing'],
  };
  @override
  void synchronizePermissions(Map<String, List<String>> permissions) =>
      updates.add(permissions);
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late ProviderContainer container;
  late Dio dio;
  late ApiClient client;
  setUp(() {
    SharedPreferences.setMockInitialValues({});
    container = ProviderContainer();
    dio = Dio(BaseOptions(baseUrl: 'https://fixture.invalid'));
    client = container.read(Provider((ref) => ApiClient(ref, transport: dio)));
    dio.interceptors.clear();
  });
  tearDown(() {
    container.dispose();
    dio.close(force: true);
  });
  void response(Object? body, {int status = 200}) {
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (request, handler) => handler.resolve(
          Response(requestOptions: request, data: body, statusCode: status),
        ),
      ),
    );
  }

  test(
    'legacy model imports preserve concrete factories and envelope serialization',
    () {
      final staff = StaffMember.fromJson({'id': 'staff-1', 'name': 'Staff'});
      expect(staff, isA<BaseEntity<String>>());
      expect(staff.toJson(), {'id': 'staff-1', 'name': 'Staff'});
      final model = DomainResponse.fromJson({
        'data': {'value': 2},
        'success': false,
        'message': 'retained',
        'error': 'error',
      });
      expect(model, isA<BaseResponseEnvelope>());
      expect(model.toJson(), {
        'data': {'value': 2},
        'success': false,
        'message': 'retained',
        'error': 'error',
      });
      expect(DomainResponse.error('failed').toJson(), {
        'data': <String, dynamic>{},
        'success': false,
        'message': null,
        'error': 'failed',
      });
    },
  );
  test('shared result guard preserves fallback and rethrow behavior', () async {
    final service = FixtureService(client, ExecutionGateService());
    expect(service.apiClient, same(client));
    expect(service.repository.client, same(client));
    expect((await service.compute()).getOrThrow(), 7);
    expect(await service.compute(rethrowError: true), isA<Failure<int>>());
  });
  test(
    'repository retains path, query and body without adding owner overrides',
    () async {
      final observed = <RequestOptions>[];
      dio.interceptors.add(
        InterceptorsWrapper(
          onRequest: (request, handler) {
            observed.add(request);
            handler.resolve(
              Response(
                requestOptions: request,
                data: {'data': 1},
                statusCode: 200,
              ),
            );
          },
        ),
      );
      final repository = ApiRepository(client);
      await repository.get('/fixture/data', queryParameters: {'limit': 5});
      await repository.post('/fixture/data', body: {'value': 'existing'});
      expect(observed.map((x) => x.method), ['GET', 'POST']);
      expect(observed.first.queryParameters, {'limit': 5});
      expect(observed.last.data, {'value': 'existing'});
      expect(observed.every((x) => x.path == '/fixture/data'), isTrue);
    },
  );
  test('cached permissions retain existing normalization', () async {
    SharedPreferences.setMockInitialValues({
      'fixture_permissions': '{"staff":["read",1]}',
    });
    final policy = FixturePolicy();
    await policy.loadCachedPermissions();
    expect(policy.updates.single, {
      'staff': ['read', '1'],
    });
  });
  test(
    'invalid cached permissions do not publish replacement grants',
    () async {
      SharedPreferences.setMockInitialValues({
        'fixture_permissions': '{"staff":false}',
      });
      final policy = FixturePolicy();
      await policy.loadCachedPermissions();
      expect(policy.updates, isEmpty);
    },
  );
  test(
    'successful permission synchronization caches the existing payload',
    () async {
      response({
        'staff': ['read'],
      });
      final policy = FixturePolicy();
      await policy.fetchAndSyncPermissions(client);
      expect(policy.updates.single, {
        'staff': ['read'],
      });
      expect(
        (await SharedPreferences.getInstance()).getString(policy.cacheKey),
        '{"staff":["read"]}',
      );
    },
  );
  test('failed remote permissions retain declared UI fallback', () async {
    response({'error': 'unavailable'}, status: 503);
    final policy = FixturePolicy();
    await policy.fetchAndSyncPermissions(client);
    expect(policy.updates.single, policy.fallbackPermissions);
  });
  test('malformed remote permissions retain declared UI fallback', () async {
    response({'staff': true});
    final policy = FixturePolicy();
    await policy.fetchAndSyncPermissions(client);
    expect(policy.updates.single, policy.fallbackPermissions);
  });
  test(
    'public notification port remains implementable with load alone',
    () async {
      final port = NarrowRepositoryFake();
      final scope = ProviderContainer(
        overrides: [ownNotificationsRepositoryProvider.overrideWithValue(port)],
      );
      final result = await scope
          .read(ownNotificationsRepositoryProvider)
          .load();
      expect(result.statusCode, 401);
      expect(result.error, 'Session expired');
      scope.dispose();
    },
  );
  test('permission configuration retains established names', () {
    const configuration = PermissionPolicyConfiguration();
    expect(configuration.cacheKey, 'primecare_role_permissions');
    expect(configuration.endpointKey, 'systemPermissions');
  });
}
