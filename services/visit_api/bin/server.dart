import 'package:server_core/server_core.dart';
// Governance - Category: service | Purpose: Fetch all clinical visits
import 'dart:io';
import 'dart:convert';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';
import 'package:database_client/database_client.dart';

Future<void> main() async {
  await VisitApiHost().run();
}

class VisitApiHost extends BaseCorsServiceHost {
  VisitApiHost() : super(serviceName: 'visit-api', defaultPort: 8080);

  @override
  Future<Handler> createRoutes() async {
    final db = PlatformDatabase();
    await db.initialize();

    final router = Router();

    router.get('/', (Request request) {
      return Response.ok('Hello from visit-api (Hydrated with Dart DB Client)');
    });

    // Fetch all clinical visits
    router.get('/api/visits', (Request request) async {
      try {
        final results = await db.query(
          'SELECT * FROM visits ORDER BY visit_date DESC',
        );
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

    // Start a new visit
    router.post('/api/visits', (Request request) async {
      try {
        final payload =
            jsonDecode(await request.readAsString()) as Map<String, dynamic>;
        await db.query(
          'INSERT INTO visits (client_id, provider_id, visit_date, status) VALUES (@clientId, @providerId, NOW(), @status)',
          substitutionValues: {
            'clientId': payload['client_id'],
            'providerId': payload['provider_id'],
            'status': 'started',
          },
        );
        return Response.ok(
          jsonEncode({'status': 'visit_created'}),
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
    print('visit-api serving at http://${server.address.host}:${server.port}');
  }
}
