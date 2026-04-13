import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';
import 'package:primecare_core/adapters/dynamic_adapter_provider.dart';
import 'package:primecare_core/adapters/dynamic_screen_adapter.dart';
import 'package:primecare_core/network/api_client.dart';
import 'package:primecare_core/api_providers.dart';

class MockApiClient implements ApiClient {
  @override
  Future<Response> get(String path, {Map<String, dynamic>? query}) async =>
      Response(
        requestOptions: RequestOptions(path: ''),
        data: {},
      );
  @override
  Future<Response> post(String path, {dynamic body}) async => Response(
    requestOptions: RequestOptions(path: ''),
    data: {},
  );
  @override
  Future<Response> put(String path, {dynamic body}) async => Response(
    requestOptions: RequestOptions(path: ''),
    data: {},
  );
  @override
  Future<Response> delete(String path, {dynamic body}) async => Response(
    requestOptions: RequestOptions(path: ''),
    data: {},
  );
}

void main() {
  test(
    'dynamicScreenAdapterProvider resolves correctly with given screenId',
    () {
      final container = ProviderContainer(
        overrides: [apiClientProvider.overrideWithValue(MockApiClient())],
      );
      addTearDown(container.dispose);

      const screenId = 'marketing_dashboard';

      // Read the adapter to ensure it initializes properly
      final adapter = container.read(dynamicScreenAdapterProvider(screenId));

      expect(adapter, isA<DynamicScreenAdapter>());
      expect(adapter.screenId, equals(screenId));
    },
  );
}
