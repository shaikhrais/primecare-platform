import 'package:flutter_test/flutter_test.dart';
import 'package:dio/dio.dart';
import 'package:primecare_core/adapters/dynamic_adapter_provider.dart';
import 'package:primecare_core/adapters/dynamic_screen_adapter.dart';
import 'package:primecare_core/flutter_core.dart';

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
  group('Dynamic Screen Adapter Batch Hydration', () {
    late ProviderContainer container;

    setUp(() {
      container = ProviderContainer(
        overrides: [apiClientProvider.overrideWithValue(MockApiClient())],
      );
    });

    tearDown(() {
      container.dispose();
    });

    final testRoutes = [
      CorporateRoutes.ceoDashboard,
      CorporateRoutes.headOfBusDevDashboard,
      FranchiseRoutes.franchiseOwnerDashboard,
      FranchiseRoutes.billingAdminDashboard,
      SupportRoutes.customerSupportDashboard,
      CommonRoutes.clinicDashboard,
      CorporateRoutes.complianceManagerDashboard,
      '/dynamic_catchall_route_test',
    ];

    for (final screenId in testRoutes) {
      test('dynamicScreenAdapterProvider resolves correctly for $screenId', () {
        // Read the adapter to ensure it initializes properly
        final adapter = container.read(dynamicScreenAdapterProvider(screenId));

        expect(adapter, isA<DynamicScreenAdapter>());
        expect(adapter.screenId, equals(screenId));
      });
    }
  });
}
