import 'dart:async';
import 'dart:convert';

import 'package:shelf/shelf.dart';
import 'package:test/test.dart';

import '../lib/routes.dart';

void main() {
  final router = ApiRoutes().router;
  for (final path in ApiRoutes.screenPaths) {
    for (final method in ['GET', 'POST']) {
      final target = method == 'GET' ? path : '$path/action';
      test(
        '$method $target reports unavailable without reading request body',
        () async {
          final body = StreamController<List<int>>();
          body.onListen = () => fail('Unsupported workflow consumed the body');
          final response = await router(
            Request(
              method,
              Uri.parse('https://service$target'),
              headers: {
                'authorization': 'Bearer invalid',
                'x-tenant-id': 'foreign',
              },
              body: method == 'POST' ? body.stream : null,
            ),
          );
          expect(response.statusCode, 501);
          expect(response.headers['cache-control'], 'no-store');
          expect(jsonDecode(await response.readAsString()), {
            'error': 'Scheduling screen workflow is not implemented',
            'status': 'not_implemented',
            'code': 'scheduling_screen_workflow_unavailable',
          });
          unawaited(body.close());
        },
      );
    }
  }
  test('unregistered routes and methods are not captured', () async {
    for (final target in [
      '/api/schedules',
      '/api/unknown-screen',
      '${ApiRoutes.screenPaths.first}/extra',
    ]) {
      expect(
        (await router(Request('GET', Uri.parse('https://service$target'))))
            .statusCode,
        404,
      );
    }
    expect(
      (await router(
        Request(
          'DELETE',
          Uri.parse('https://service${ApiRoutes.screenPaths.first}'),
        ),
      )).statusCode,
      404,
    );
  });
}
