import 'package:server_core/server_core.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';
import 'package:test/test.dart';

class TestRoutes extends BaseApiRoutes {
  int registrations = 0;
  @override
  void registerRoutes(Router router) {
    registrations++;
    router.get(
      '/existing/<id>',
      (Request request, String id) => Response.ok(id),
    );
    router.post(
      '/existing',
      (Request request) async => Response(
        202,
        body: await request.readAsString(),
        headers: {'x-custom': 'retained'},
      ),
    );
  }
}

void main() {
  test('creates independent routers and retains route matching', () async {
    final routes = TestRoutes();
    final first = routes.router;
    final second = routes.router;
    expect(identical(first, second), isFalse);
    expect(routes.registrations, 2);
    for (final router in [first, second]) {
      final response = await router(
        Request('GET', Uri.parse('https://api/existing/123')),
      );
      expect(await response.readAsString(), '123');
      expect(
        (await router(
          Request('DELETE', Uri.parse('https://api/existing/123')),
        )).statusCode,
        404,
      );
      expect(
        (await router(
          Request('GET', Uri.parse('https://api/unknown')),
        )).statusCode,
        404,
      );
    }
  });
  test('retains body, status, and headers from service handlers', () async {
    final response = await TestRoutes().router(
      Request('POST', Uri.parse('https://api/existing'), body: 'original body'),
    );
    expect(response.statusCode, 202);
    expect(response.headers['x-custom'], 'retained');
    expect(await response.readAsString(), 'original body');
  });
}
