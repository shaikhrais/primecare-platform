import 'package:server_core/server_core.dart';
// Governance - Category: service | Purpose: Edge API service engine running request listeners and background worker micro-tasks.
import 'dart:io';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';
import 'package:shelf_cors_headers/shelf_cors_headers.dart';

Future<void> main() async {
  await NotificationApiHost().run();
}

class NotificationApiHost extends BaseServiceHost {
  NotificationApiHost()
    : super(serviceName: 'notification-api', defaultPort: 8080);

  @override
  Future<Handler> createHandler() async {
    final router = Router();
    router.get(
      '/',
      (Request request) =>
          Response.ok('Hello from notification-api (Migrated to Dart)'),
    );
    final handler = const Pipeline()
        .addMiddleware(logRequests())
        .addMiddleware(corsHeaders())
        .addHandler(router.call);
    return handler;
  }

  @override
  void onStarted(HttpServer server) {
    print('notification-api serving at http://0.0.0.0:${server.port}');
  }
}
