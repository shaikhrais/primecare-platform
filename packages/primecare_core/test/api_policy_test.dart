import 'package:primecare_core/primecare_core.dart';
import 'package:test/test.dart';

void main() {
  test('explicit URL takes precedence on every platform', () {
    for (final web in [true, false]) {
      expect(
        ApiConfiguration.resolveBaseUrl(
          isWeb: web,
          configured: 'https://example.test/api',
        ),
        'https://example.test/api',
      );
      expect(ApiConfiguration.resolveBaseUrl(isWeb: web, configured: ' '), ' ');
    }
    expect(ApiConfiguration.resolveBaseUrl(isWeb: true, configured: ''), '');
    expect(
      ApiConfiguration.resolveBaseUrl(isWeb: false, configured: ''),
      'https://primecare-api-gateway.itpro-mohammed.workers.dev',
    );
  });
  test('shared alias map retains its entries and is immutable', () {
    expect(ApiConfiguration.endpoints.length, 16);
    expect(ApiConfiguration.endpoints['login'], '/v1/auth/login');
    expect(
      ApiConfiguration.endpoints['providerDashboard'],
      ApiConfiguration.endpoints['providerProfile'],
    );
    expect(
      () => ApiConfiguration.endpoints['new'] = '/new',
      throwsUnsupportedError,
    );
    expect(ApiConfiguration.endpoints['intakeCases'], isNull);
  });
  test('HTTP rules retain precedence over connection timeout', () {
    final messages = {
      401: 'Session expired.',
      403: 'Access denied.',
      400: 'Invalid request',
      404: 'The requested resource',
      500: 'Internal Server Error.',
    };
    for (final entry in messages.entries) {
      expect(
        ApiErrorPolicy.mapResponse(
          statusCode: entry.key,
          connectionTimeout: true,
        ),
        startsWith(entry.value),
      );
    }
    expect(
      ApiErrorPolicy.mapResponse(statusCode: 502, connectionTimeout: true),
      startsWith('Connection timed out.'),
    );
    expect(
      ApiErrorPolicy.mapResponse(statusCode: 502),
      startsWith('An unexpected error'),
    );
  });
  test(
    '400 payload retains conversion, default and malformed-data behavior',
    () {
      expect(
        ApiErrorPolicy.mapResponse(statusCode: 400, data: {'message': 42}),
        '42',
      );
      expect(
        ApiErrorPolicy.mapResponse(statusCode: 400, data: <String, dynamic>{}),
        'Invalid request submitted.',
      );
      expect(
        () => ApiErrorPolicy.mapResponse(statusCode: 400, data: <dynamic>[]),
        throwsA(isA<TypeError>()),
      );
    },
  );
}
