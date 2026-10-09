import 'package:server_core/server_core.dart';
// Governance - Category: service | Purpose: Edge API service engine running request listeners and background worker micro-tasks.
import 'dart:io';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

Future<void> main() async {
  await NotesApiHost().run();
}

class NotesApiHost extends BaseCorsServiceHost {
  NotesApiHost() : super(serviceName: 'notes-api', defaultPort: 8080);

  @override
  Future<Handler> createRoutes() async {
    final router = Router();
    router.get(
      '/',
      (Request request) =>
          Response.ok('Hello from notes-api (Migrated to Dart)'),
    );
    return router.call;
  }

  @override
  void onStarted(HttpServer server) {
    print('notes-api serving at http://0.0.0.0:${server.port}');
  }
}
