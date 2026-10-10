import 'dart:convert';
import 'package:test/test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:primecare_core/primecare_core.dart';

void main() {
  test('adapter preserves gateway prefix and bearer contract', () async {
    final client = MockClient((request) async {
      expect(request.url.toString(), 'https://example.com/auth/login');
      expect(request.headers['authorization'], 'Bearer token');
      expect(jsonDecode(request.body), {'email': 'user@example.com'});
      return http.Response('{"status":"authenticated"}', 200);
    });
    await HttpAuthTransport('https://example.com/auth/', client).send(
      'POST',
      '/login',
      token: 'token',
      body: {'email': 'user@example.com'},
    );
    client.close();
  });
  test('adapter forwards authentication failure status', () async {
    final client = MockClient(
      (_) async => http.Response('{"error":"Invalid session"}', 401),
    );
    await expectLater(
      HttpAuthTransport('https://example.com', client).send('GET', '/me'),
      throwsA(isA<AuthFailure>().having((e) => e.status, 'status', 401)),
    );
    client.close();
  });
  test(
    'configuration failures use AuthFailure instead of escaping into UI',
    () {
      final client = MockClient((_) async => http.Response('{}', 200));
      for (final url in [
        '',
        'http://example.com',
        'https://',
        'https://[',
        'https://user:password@example.com',
        'https://example.com?token=x',
      ]) {
        expect(
          () => HttpAuthTransport(url, client),
          throwsA(isA<AuthFailure>()),
        );
      }
      client.close();
    },
  );
  test('malformed service response is a safe retryable failure', () async {
    final client = MockClient(
      (_) async => http.Response('<private error>', 503),
    );
    await expectLater(
      HttpAuthTransport('https://example.com', client).send('GET', '/me'),
      throwsA(
        isA<AuthFailure>().having(
          (e) => e.message,
          'message',
          'Authentication service unavailable. Please try again.',
        ),
      ),
    );
    client.close();
  });
  test(
    'anonymous login omits authorization and disables automatic redirects',
    () async {
      final client = MockClient((request) async {
        expect(request.headers.containsKey('authorization'), isFalse);
        expect(request.followRedirects, isFalse);
        return http.Response('{}', 200);
      });
      await HttpAuthTransport('https://example.com', client).send(
        'POST',
        '/login',
        body: {'email': 'a@b.com', 'password': 'password'},
      );
      client.close();
    },
  );
}
