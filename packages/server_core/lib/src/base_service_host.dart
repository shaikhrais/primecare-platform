import 'dart:io';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart';

typedef ServerListener =
    Future<HttpServer> Function(
      Handler handler,
      InternetAddress address,
      int port,
    );

/// Shared startup only. Service-specific routes, authority and middleware stay local.
abstract class BaseServiceHost {
  final String serviceName;
  final int defaultPort;
  const BaseServiceHost({required this.serviceName, this.defaultPort = 8080});

  Future<Handler> createHandler();

  Future<HttpServer> run({
    Map<String, String>? environment,
    InternetAddress? address,
    ServerListener? listener,
  }) async {
    final handler = await createHandler();
    final port = int.parse(
      (environment ?? Platform.environment)['PORT'] ?? defaultPort.toString(),
    );
    final server = await (listener ?? serve)(
      handler,
      address ?? InternetAddress.anyIPv4,
      port,
    );
    onStarted(server);
    return server;
  }

  void onStarted(HttpServer server) {
    print(
      '$serviceName serving at http://${server.address.host}:${server.port}',
    );
  }
}
