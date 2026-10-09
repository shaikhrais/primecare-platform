import 'package:server_core/server_core.dart';
// Governance - Category: service | Purpose: Fetch all providers
import 'dart:io';
import 'dart:convert';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';
import 'package:database_client/database_client.dart';



class ProviderApiHost extends BaseCorsServiceHost {
  ProviderApiHost() : super(serviceName: 'provider-api', defaultPort: 8080);

  @override
  Future<Handler> createRoutes() async {
    final db = PlatformDatabase();
    await db.initialize();

    final router = Router();

    router.get('/', (Request request) {
      return Response.ok(
        'Hello from provider-api (Hydrated with Dart DB Client)',
      );
    });

    // Fetch all providers
    router.get('/api/providers', (Request request) async {
      try {
        final results = await db.query('SELECT * FROM providers');
        return Response.ok(
          jsonEncode(results),
          headers: {'Content-Type': 'application/json'},
        );
      } catch (e) {
        return Response.internalServerError(
          body: jsonEncode({'error': e.toString()}),
          headers: {'Content-Type': 'application/json'},
        );
      }
    });

    // Fetch provider by ID
    router.get('/api/providers/<id>', (Request request, String id) async {
      try {
        final results = await db.query(
          'SELECT * FROM providers WHERE id = @id',
          substitutionValues: {'id': id},
        );
        if (results.isEmpty) return Response.notFound('Provider not found');
        return Response.ok(
          jsonEncode(results.first),
          headers: {'Content-Type': 'application/json'},
        );
      } catch (e) {
        return Response.internalServerError(
          body: jsonEncode({'error': e.toString()}),
          headers: {'Content-Type': 'application/json'},
        );
      }
    });

    return router.call;
  }

  @override
  void onStarted(HttpServer server) {
    print(
      'provider-api serving at http://${server.address.host}:${server.port}',
    );
  }
}
