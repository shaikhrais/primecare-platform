import 'package:server_core/server_core.dart';
// Governance - Category: service | Purpose: Mount the 456 AI-generated routes Fetch all schedules with Client and Provider names (JOIN Example)
import 'dart:io';
import 'dart:convert';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';
import 'package:scheduling_api/routes.dart';
import 'package:database_client/database_client.dart';



class SchedulingApiHost extends BaseCorsServiceHost {
  SchedulingApiHost() : super(serviceName: 'scheduling-api', defaultPort: 8080);

  @override
  Future<Handler> createRoutes() async {
    final db = PlatformDatabase();
    await db.initialize();

    final router = Router();

    // Mount the 456 AI-generated routes
    final apiRoutes = ApiRoutes();
    router.mount('/', apiRoutes.router.call);

    router.get('/', (Request request) {
      return Response.ok(
        'Hello from scheduling-api (Hydrated with Dart DB Client)',
      );
    });

    // Fetch all schedules with Client and Provider names (JOIN Example)
    router.get('/api/schedules', (Request request) async {
      try {
        final query = '''
        SELECT 
          s.id, 
          s.start_time, 
          s.end_time, 
          c.first_name as client_name, 
          p.first_name as provider_name 
        FROM schedules s
        JOIN clients c ON s.client_id = c.id
        JOIN providers p ON s.provider_id = p.id
      ''';
        final results = await db.query(query);
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

    return router.call;
  }

  @override
  void onStarted(HttpServer server) {
    print(
      'scheduling-api serving at http://${server.address.host}:${server.port}',
    );
  }
}
