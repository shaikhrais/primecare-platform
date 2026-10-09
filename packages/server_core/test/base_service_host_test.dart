import 'dart:io';
import 'package:server_core/server_core.dart';
import 'package:shelf/shelf.dart';
import 'package:test/test.dart';

class TestHost extends BaseServiceHost {
  int handlerCalls = 0;
  int startedCalls = 0;
  TestHost({int port = 0}) : super(serviceName: 'fixture', defaultPort: port);
  @override
  Future<Handler> createHandler() async {
    handlerCalls++;
    return (request) => Response.ok('inherited lifecycle');
  }

  @override
  void onStarted(HttpServer server) {
    startedCalls++;
  }
}

void main() {
  test(
    'base host serves the concrete handler and honors port override',
    () async {
      final host = TestHost(port: 8800);
      final server = await host.run(
        environment: {'PORT': '0'},
        address: InternetAddress.loopbackIPv4,
      );
      addTearDown(() => server.close(force: true));
      final client = HttpClient();
      addTearDown(client.close);
      final request = await client.getUrl(
        Uri.parse('http://127.0.0.1:${server.port}/fixture'),
      );
      final response = await request.close();
      expect(response.statusCode, 200);
      expect(host.handlerCalls, 1);
      expect(host.startedCalls, 1);
    },
  );
  test('invalid configured port refuses before opening a listener', () async {
    final host = TestHost();
    var listening = false;
    await expectLater(
      host.run(
        environment: {'PORT': 'invalid'},
        listener: (handler, address, port) async {
          listening = true;
          throw StateError('unexpected listener');
        },
      ),
      throwsFormatException,
    );
    expect(listening, isFalse);
    expect(host.startedCalls, 0);
  });
}
