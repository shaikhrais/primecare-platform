import 'dart:typed_data';
import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_core/src/network/api_client.dart';
import 'package:flutter_core/src/network/local_cache_service.dart';
import 'package:flutter_core/application_modules/application_workflow_paths.dart';

// Exact existing declaration identities; no new operation or permission is registered.
const _applicationPaths = [
 '/v1/admin/erp/purchase-orders', '/v1/user/training/catalog',
 '/v1/user/training/my-progress', '/v1/ai/insights', '/v1/ai/predictive',
 '/v1/ai/churn', '/v1/support/chat', '/v1/psw/help-support',
 '/v1/premium/transactionledger',
];
const _staleData = <String, dynamic>{'record': 'another-session-cached-data'};
const _errorData = <String, dynamic>{'error': 'executive read unavailable'};
const _realData = <String, dynamic>{'record': 'actual-transport-data'};

class _ProbeCache extends LocalCacheService {
  _ProbeCache(this.cachedData) : super(null);

  final Map<String, dynamic>? cachedData;
  int reads = 0;
  int writes = 0;

  @override
  Map<String, dynamic>? getCachedResponse(String path) {
    reads++;
    return cachedData;
  }

  @override
  Future<void> cacheResponse(String path, Map<String, dynamic> data) async {
    writes++;
  }
}

// Even a broken fixture must not open a socket.
class _NoNetworkAdapter implements HttpClientAdapter {
  int attempts = 0;

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) async {
    attempts++;
    throw StateError('Network access is forbidden in this test.');
  }

  @override
  void close({bool force = false}) {}
}

class _Harness {
  _Harness({Map<String, dynamic>? cachedData})
      : cache = _ProbeCache(cachedData) {
    container = ProviderContainer(
      overrides: [localCacheServiceProvider.overrideWithValue(cache)],
    );
    dio = Dio(BaseOptions(baseUrl: 'https://api.example.invalid'));
    dio.httpClientAdapter = adapter;
    client = container.read(
      Provider((ref) => ApiClient(ref, transport: dio)),
    );
    // This isolates ApiClient's failure boundary from session/device plugins.
    dio.interceptors.clear();
    addTearDown(() {
      expect(adapter.attempts, 0);
      dio.close(force: true);
      container.dispose();
    });
  }

  final _ProbeCache cache;
  final _NoNetworkAdapter adapter = _NoNetworkAdapter();
  late final ProviderContainer container;
  late final Dio dio;
  late final ApiClient client;
  int requests = 0;

  void fail(DioExceptionType type, {int? statusCode}) {
    dio.interceptors.add(InterceptorsWrapper(onRequest: (options, handler) {
      requests++;
      handler.reject(DioException(
        requestOptions: options,
        type: type,
        response: statusCode == null
            ? null
            : Response(
                requestOptions: options,
                statusCode: statusCode,
                data: _errorData,
              ),
      ));
    }));
  }

  void respond(int? statusCode) {
    dio.interceptors.add(InterceptorsWrapper(onRequest: (options, handler) {
      requests++;
      handler.resolve(Response(
        requestOptions: options,
        statusCode: statusCode,
        data: _realData,
      ));
    }));
  }

  void expectUncached() {
    expect(requests, 1);
    expect(cache.reads, 0);
    expect(cache.writes, 0);
    expect(adapter.attempts, 0);
  }
}

void _expectFailure(ApiResponse response, int statusCode, dynamic data) {
  expect(response.statusCode, statusCode);
  expect(response.isSuccess, isFalse);
  expect(response.error, isNotNull);
  expect(response.data, data);
}

Future<ApiResponse> send(_Harness h,String method,String path) => switch(method){
 'GET'=>h.client.get(path), 'POST'=>h.client.post(path,body:<String,dynamic>{}),
 'PUT'=>h.client.put(path,body:<String,dynamic>{}),
 'PATCH'=>h.client.patch(path,body:<String,dynamic>{}), _=>h.client.delete(path),
};
void main(){
 TestWidgetsFlutterBinding.ensureInitialized();
 final recorded=jsonDecode(File('test/application_modules/fixtures/application_workflow_identities.json').readAsStringSync()) as Map<String,dynamic>;
 final declarations=List<Map<String,dynamic>>.from((recorded['operations'] as List).map((row)=>Map<String,dynamic>.from(row as Map)));
 test('all114recorded declarations remain failure boundaries, never grants',(){
  expect(declarations,hasLength(114));expect(recorded['noActivation'],isTrue);
  for(final row in declarations){expect(isApplicationWorkflowPath((row['path'] as String).replaceAll('{id}','fixture-record')),isTrue);}
 });
 for(final row in declarations){
  final path=(row['path'] as String).replaceAll('{id}','fixture-record');
  test('registered API${row['id']} failure cannot expose stale cache or synthetic success',()async{
   final h=_Harness(cachedData:_staleData);h.fail(DioExceptionType.connectionError);
   _expectFailure(await send(h,row['method'] as String,path),503,isEmpty);h.expectUncached();
  });
 }
 test('failed help request never invents a reachable support service',()async{
  final h=_Harness(cachedData:_staleData);h.fail(DioExceptionType.connectionError);
  final response=await h.client.post('/v1/psw/help-support',body:<String,dynamic>{});
  expect(response.isSuccess,isFalse);expect(response.statusCode,503);
  expect(response.data,isEmpty);h.expectUncached();
 });
 for(final path in _applicationPaths){
  for(final method in ['GET','POST','PUT','PATCH','DELETE']){
   for(final status in [null,400,401,403,404,405,409,429,500,503]){
    test('$method $path preserves failure $status without stale cache or invented success',()async{
     final h=_Harness(cachedData:_staleData);
     h.fail(status==null?DioExceptionType.connectionError:DioExceptionType.badResponse,statusCode:status);
     _expectFailure(await send(h,method,path),status??503,status==null?isEmpty:_errorData);
     h.expectUncached();
    });
   }
   for(final status in [200,201,299]){
    test('$method $path returns actual $status data without private path-only cache',()async{
     final h=_Harness(cachedData:_staleData);h.respond(status);
     final response=await send(h,method,path);
     expect(response.statusCode,status);expect(response.isSuccess,isTrue);
     expect(response.data,_realData);h.expectUncached();
    });
   }
   test('$method $path missing transport status cannot become success',()async{
    final h=_Harness(cachedData:_staleData);h.respond(null);
    expect((await send(h,method,path)).statusCode,503);h.expectUncached();
   });
   test('$method $path an error carrying 200 cannot become success',()async{
    final h=_Harness(cachedData:_staleData);h.fail(DioExceptionType.unknown,statusCode:200);
    _expectFailure(await send(h,method,path),503,_errorData);h.expectUncached();
   });
  }
  for(final variant in ['$path?enable-semantics=true','$path/',
   'https://api.example.invalid$path?enable-semantics=true',
   path.substring(1),'../'+path.substring(1)]){
   test('$variant is the same failure boundary',()async{
    expect(isApplicationWorkflowPath(variant),isTrue);
    final h=_Harness(cachedData:_staleData);h.fail(DioExceptionType.connectionTimeout);
    _expectFailure(await h.client.get(variant),503,isEmpty);h.expectUncached();
   });
  }
  for(final unrelated in ['$path-extra','$path/child']){
   test('$unrelated does not acquire a new policy',(){
    expect(isApplicationWorkflowPath(unrelated),isFalse);
   });
  }
 }
 test('recorded trailing slash route uses the same normalized identity',(){
  expect(isApplicationWorkflowPath('/v1/marketing/'),isTrue);
  expect(isApplicationWorkflowPath('/v1/marketing'),isTrue);
  expect(isApplicationWorkflowPath('/v1/marketing-extra'),isFalse);
 });
 test('recorded parameter template matches one path segment only',(){
  expect(isApplicationWorkflowPath('/v1/governance/look/reviews/owned-review/ai'),isTrue);
  expect(isApplicationWorkflowPath('/v1/governance/look/reviews/a/b/ai'),isFalse);
  expect(isApplicationWorkflowPath('/v1/governance/look/reviews/owned-review/ai-extra'),isFalse);
 });
 test('unrelated offline behavior is outside this repair',()async{
  final h=_Harness(cachedData:_staleData);h.fail(DioExceptionType.connectionError);
  expect((await h.client.get('/v1/unrelated-fixture')).data,_staleData);
  expect(h.cache.reads,1);expect(h.cache.writes,0);
 });
}
