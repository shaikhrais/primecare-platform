import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_core/auth_service.dart';
import 'package:flutter_core/platform/platform_master_repository.dart';
import 'package:flutter_core/src/network/api_client.dart';

class CurrentPlatformActor extends AuthNotifier {
  @override
  AuthState build() => AuthState(isInitialized: true, isAuthenticated: true,
    userId: 'new-actor', tenantId: 'new-tenant', token: 'new-token', role: 'code_admin');
}
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  test('real interceptor preserves captured authorization and omits automatic platform tenant override', () async {
    debugDefaultTargetPlatformOverride = TargetPlatform.linux;
    addTearDown(() => debugDefaultTargetPlatformOverride = null);
    final container = ProviderContainer(overrides: [authProvider.overrideWith(CurrentPlatformActor.new)]);
    final dio = Dio(BaseOptions(baseUrl: 'https://synthetic.invalid'));
    addTearDown(() { dio.close(force: true); container.dispose(); });
    final client = container.read(Provider((ref) => ApiClient(ref, transport: dio)));
    var calls = 0;
    // Runs after the actual SecurityInterceptor installed by ApiClient.
    dio.interceptors.add(InterceptorsWrapper(onRequest: (options, handler) {
      calls++;
      if (options.path == '/v1/provider/profile') {
        expect(options.headers['Authorization'], 'Bearer new-token');
        expect(options.headers['X-Tenant-ID'], 'new-tenant');
        handler.resolve(Response(requestOptions: options, statusCode: 200, data: <String, dynamic>{}));
        return;
      }
      expect(options.headers['Authorization'], 'Bearer old-token');
      expect(options.headers.keys.any((key) => key.toLowerCase() == 'x-tenant-id'), isFalse);
      expect(options.headers['Cache-Control'], 'no-store');
      if (options.method == 'GET') {
        handler.resolve(Response(requestOptions: options, statusCode: 200, data: {
          'identity': {'userId': 'old-actor'}, 'tenants': [{'id': 'tenant-a', 'name': 'Clinic'}], 'masterTypes': ['department'],
        }));
      } else {
        expect(options.headers['Idempotency-Key'], 'same-command-123456');
        handler.resolve(Response(requestOptions: options, statusCode: 201, data: {'record': {
          'id': 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', 'type': 'department', 'code': 'hr',
          'label': 'HR', 'status': 'active', 'version': 1,
        }}));
      }
    }));
    final repository = PlatformMasterRepository(client, actor: 'old-actor', token: 'old-token');
    final index = await repository.index();
    final receipt = await repository.create(index, 'tenant-a', {'type': 'department', 'code': 'hr', 'label': 'HR'}, 'same-command-123456');
    expect(receipt.label, 'HR'); expect(calls, 2);
    await client.get('/v1/provider/profile'); expect(calls, 3);
  });
}
