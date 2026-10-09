import 'package:server_core/server_core.dart';
// Governance - Category: service | Purpose: Mount the 456 AI-generated routes Fetch all invoices
import 'dart:io';
import 'dart:convert';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';
import 'package:billing_api/routes.dart';
import 'package:shelf_cors_headers/shelf_cors_headers.dart';
import 'package:database_client/database_client.dart';

Future<void> main() async {
  await BillingApiHost().run();
}

class BillingApiHost extends BaseServiceHost {
  BillingApiHost() : super(serviceName: 'billing-api', defaultPort: 8080);

  @override
  Future<Handler> createHandler() async {
    final db = PlatformDatabase();
    await db.initialize();

    final router = Router();

    // Mount the 456 AI-generated routes
    final apiRoutes = ApiRoutes();
    router.mount('/', apiRoutes.router.call);

    router.get('/', (Request request) {
      return Response.ok(
        'Hello from billing-api (Hydrated with Dart DB Client)',
      );
    });

    // Fetch all invoices
    router.get('/api/invoices', (Request request) async {
      try {
        final results = await db.query('SELECT * FROM invoices');
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

    final handler = const Pipeline()
        .addMiddleware(logRequests())
        .addMiddleware(corsHeaders())
        .addHandler(router.call);

    return handler;
  }

  @override
  void onStarted(HttpServer server) {
    print(
      'billing-api serving at http://${server.address.host}:${server.port}',
    );
  }
}
