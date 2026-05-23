// Governance - Category: test | Purpose: Core implementation file for the Dynamic Adapter Resolver Test platform logic.
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_core/flutter_core.dart';

class MockApiClient implements ApiClient {
  @override
  Future<ApiResponse> get(
    String path, {
    Map<String, dynamic>? queryParameters,
  }) async {
    return ApiResponse(data: {'role': 'psw'}, statusCode: 200);
  }

  @override
  Future<ApiResponse> post(String path, {dynamic body}) async {
    return ApiResponse(data: <String, dynamic>{}, statusCode: 200);
  }

  @override
  Future<ApiResponse> put(String path, {dynamic body}) async {
    return ApiResponse(data: <String, dynamic>{}, statusCode: 200);
  }

  @override
  Future<ApiResponse> delete(String path) async {
    return ApiResponse(data: <String, dynamic>{}, statusCode: 200);
  }
}

void main() {
  group('DynamicScreenAdapter - Registry Resolution', () {
    late ProviderContainer container;
    late MockApiClient mockApi;

    setUp(() {
      mockApi = MockApiClient();
      container = ProviderContainer(
        overrides: [apiClientProvider.overrideWithValue(mockApi)],
      );
    });

    tearDown(() {
      container.dispose();
    });

    test('Registry contains pswDashboard', () {
      expect(PrimeCareForm.values, contains(PrimeCareForm.pswDashboard));
    });

    test('DynamicScreenAdapter - Correctly binds form to view model', () async {
      const form = PrimeCareForm.pswDashboard;

      // In Riverpod, we can get this by creating a simple provider.
      final refProvider = Provider((ref) => ref);
      final ref = container.read(refProvider);

      final response = await mockApi.get('/test');
      expect((response.data as Map<String, dynamic>)['role'], equals('psw'));

      final adapter = DynamicScreenAdapter(ref, form);

      final viewModelAsync = adapter.watchData();
      final result = viewModelAsync.value!;
      final viewModel = result.fold((d) => d, (e) => throw e);

      expect(viewModel, isA<PrimeCareDashboardViewModel>());
      expect(viewModel.metrics, isNotNull);
    });
  });
}
