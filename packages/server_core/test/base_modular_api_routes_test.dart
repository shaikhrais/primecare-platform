import 'package:server_core/server_core.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';
import 'package:test/test.dart';

class FeatureRoutes extends BaseApiRoutes {
  final String name;
  final List<String> registrations;
  FeatureRoutes(this.name, this.registrations);

  @override
  void registerRoutes(Router router) {
    registrations.add(name);
    router.get('/shared', (Request request) => Response.ok(name));
    router.post('/$name', (Request request) async => Response(
      202,
      body: await request.readAsString(),
      headers: {'x-feature': name},
    ));
  }
}

class ServiceRoutes extends BaseModularApiRoutes {
  final List<String> registrations = [];
  @override
  Iterable<BaseApiRoutes> get modules => [
    FeatureRoutes('first', registrations),
    FeatureRoutes('second', registrations),
  ];
}

void main() {
  test('module order preserves first-match routing for every fresh router', () async {
    final service = ServiceRoutes();
    final first = service.router;
    final second = service.router;
    expect(identical(first, second), isFalse);
    expect(service.registrations, ['first', 'second', 'first', 'second']);
    for (final router in [first, second]) {
      final response = await router(Request('GET', Uri.parse('https://api/shared')));
      expect(await response.readAsString(), 'first');
      expect((await router(Request('DELETE', Uri.parse('https://api/shared')))).statusCode, 404);
    }
  });

  test('modules retain independent request bodies, status and headers', () async {
    final router = ServiceRoutes().router;
    final responses = await Future.wait([
      router(Request('POST', Uri.parse('https://api/first'), body: 'one')),
      router(Request('POST', Uri.parse('https://api/second'), body: 'two')),
    ]);
    expect(responses.map((r) => r.statusCode), [202, 202]);
    expect(responses.map((r) => r.headers['x-feature']), ['first', 'second']);
    expect(await Future.wait(responses.map((r) => r.readAsString())), ['one', 'two']);
  });
}
