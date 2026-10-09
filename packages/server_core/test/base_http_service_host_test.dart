import 'package:server_core/server_core.dart';
import 'package:shelf/shelf.dart';
import 'package:test/test.dart';

class OrderedHost extends BaseHttpServiceHost {
  final List<String> events;
  int routeBuilds = 0;
  OrderedHost(this.events) : super(serviceName: 'ordered');
  Middleware layer(String name) =>
      (inner) => (request) async {
        events.add('$name:request');
        final response = await inner(request);
        events.add('$name:response');
        return response;
      };
  @override
  List<Middleware> get middleware => [layer('first'), layer('second')];
  @override
  Future<Handler> createRoutes() async {
    routeBuilds++;
    return (request) {
      events.add('route');
      return Response(403, body: 'denied', headers: {'x-route': 'retained'});
    };
  }
}

class AuthPolicyHost extends BaseHttpServiceHost {
  const AuthPolicyHost() : super(serviceName: 'auth-policy');
  @override
  Future<Handler> createRoutes() async =>
      (request) => Response.ok('ok');
}

class CorsPolicyHost extends BaseCorsServiceHost {
  const CorsPolicyHost() : super(serviceName: 'cors-policy');
  @override
  Future<Handler> createRoutes() async =>
      (request) => Response(401, body: 'denied');
}

void main() {
  test('pipeline retains outermost order and route response', () async {
    final events = <String>[];
    final host = OrderedHost(events);
    final handler = await host.createHandler();
    final response = await handler(
      Request('GET', Uri.parse('http://localhost/')),
    );
    expect(host.routeBuilds, 1);
    expect(events, [
      'first:request',
      'second:request',
      'route',
      'second:response',
      'first:response',
    ]);
    expect(response.statusCode, 403);
    expect(response.headers['x-route'], 'retained');
    expect(await response.readAsString(), 'denied');
  });
  test('base HTTP policy adds no CORS permissions', () async {
    final handler = await const AuthPolicyHost().createHandler();
    final response = await handler(
      Request(
        'GET',
        Uri.parse('http://localhost/'),
        headers: {'origin': 'https://example.test'},
      ),
    );
    expect(
      response.headers.containsKey('access-control-allow-origin'),
      isFalse,
    );
  });
  test('default CORS policy retains headers on denied responses', () async {
    final handler = await const CorsPolicyHost().createHandler();
    final response = await handler(
      Request(
        'GET',
        Uri.parse('http://localhost/'),
        headers: {'origin': 'https://example.test'},
      ),
    );
    expect(response.statusCode, 401);
    expect(
      response.headers['access-control-allow-origin'],
      'https://example.test',
    );
    expect(await response.readAsString(), 'denied');
  });
  test(
    'default CORS policy handles preflight without claiming route success',
    () async {
      final handler = await const CorsPolicyHost().createHandler();
      final response = await handler(
        Request(
          'OPTIONS',
          Uri.parse('http://localhost/'),
          headers: {
            'origin': 'https://example.test',
            'access-control-request-method': 'POST',
          },
        ),
      );
      expect(response.statusCode, 200);
      expect(
        response.headers['access-control-allow-methods'],
        contains('POST'),
      );
    },
  );
}
