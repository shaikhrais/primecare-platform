import 'package:flutter_test/flutter_test.dart';
import 'package:primecare_core/00_B_flutter_core.dart';
import 'package:dio/dio.dart';

class MockApiClient implements ApiClient {

  @override
  Future<Response<dynamic>> get(String path, {Map<String, dynamic>? query}) async {
    return Response<dynamic>(
      requestOptions: RequestOptions(path: path),
      data: <String, dynamic>{},
      statusCode: 200,
    );
  }

  @override
  Future<Response<dynamic>> post(String path, {dynamic body}) async {
    return Response<dynamic>(
      requestOptions: RequestOptions(path: path),
      data: <String, dynamic>{},
      statusCode: 200,
    );
  }

  @override
  Future<Response<dynamic>> put(String path, {dynamic body}) async {
    return Response<dynamic>(
      requestOptions: RequestOptions(path: path),
      data: <String, dynamic>{},
      statusCode: 200,
    );
  }

  @override
  Future<Response<dynamic>> delete(String path, {dynamic body}) async {
    return Response<dynamic>(
      requestOptions: RequestOptions(path: path),
      data: <String, dynamic>{},
      statusCode: 200,
    );
  }
}

void main() {
  group('Dynamic Form Registry Validation', () {
    late ProviderContainer container;

    setUp(() {
      container = ProviderContainer(
        overrides: [
          apiClientProvider.overrideWithValue(MockApiClient()),
        ],
      );
    });

    tearDown(() {
      container.dispose();
    });

    test('Verify all PrimeCareForm enum values have associated providers', () {
      for (final form in PrimeCareForm.values) {
        // This should not throw and should return a valid provider
        final provider = primecareFormProvider(form);
        expect(provider, isNotNull, reason: 'Form $form must have a valid provider configured.');
        
        // Optionally verify that we can read the provider (it will return a FutureProvider)
        final adapter = container.read(provider);
        expect(adapter, isA<AsyncValue<DynamicScreenAdapter>>(), reason: 'Provider for $form must be an AsyncValue provider.');
      }
    });

    test('DynamicScreenAdapter correctly binds to form registry', () {
      final form = PrimeCareForm.ceoDashboard;
      
      // We need a Ref that is associated with our container.
      // In Riverpod, we can get this by creating a simple provider.
      final refProvider = Provider((ref) => ref);
      final ref = container.read(refProvider);
      
      final adapter = DynamicScreenAdapter(ref, form);
      
      expect(adapter.form, equals(form));
      expect(adapter.watchData(), isA<AsyncValue<PrimeCareDashboardViewModel>>());
    });
  });
}
