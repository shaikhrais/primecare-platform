import 'package:server_core/server_core.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

class NotesServiceRoutes extends BaseApiRoutes {
  @override
  void registerRoutes(Router router) {
    router.get(
      '/',
      (Request request) =>
          Response.ok('Hello from notes-api (Migrated to Dart)'),
    );

  }
}
