import 'package:server_core/server_core.dart';
// Governance - Category: service | Purpose: Edge API service engine running request listeners and background worker micro-tasks.
import 'dart:io';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';
import 'package:shelf_cors_headers/shelf_cors_headers.dart';

Future<void> main() async {
  await NotesApiHost().run();
}

class NotesApiHost extends BaseServiceHost {
  NotesApiHost() : super(serviceName: 'notes-api', defaultPort: 8080);

  @override
  Future<Handler> createHandler() async {
    final router = Router();
    router.get(
      '/',
      (Request request) =>
          Response.ok('Hello from notes-api (Migrated to Dart)'),
    );
    final handler = const Pipeline()
        .addMiddleware(logRequests())
        .addMiddleware(corsHeaders())
        .addHandler(router.call);
    return handler;
  }

  @override
  void onStarted(HttpServer server) {
    print('notes-api serving at http://0.0.0.0:${server.port}');
  }
}
