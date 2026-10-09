import 'package:server_core/server_core.dart';
// Governance - Category: service | Purpose: Mount the 456 AI-generated routes Fetch compliance audits
import 'dart:io';
import 'dart:convert';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';
import 'package:compliance_api/routes.dart';
import 'package:shelf_cors_headers/shelf_cors_headers.dart';
import 'package:database_client/database_client.dart';

Future<void> main() async {
  await ComplianceApiHost().run();
}

class ComplianceApiHost extends BaseServiceHost {
  ComplianceApiHost() : super(serviceName: 'compliance-api', defaultPort: 8080);

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
        'Hello from compliance-api (Hydrated with Dart DB Client)',
      );
    });

    // Fetch compliance audits
    router.get('/api/compliance/audits', (Request request) async {
      try {
        final results = await db.query(
          'SELECT * FROM compliance_audits ORDER BY created_at DESC',
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

    // Register a new compliance finding
    router.post('/api/compliance/findings', (Request request) async {
      try {
        final payload =
            jsonDecode(await request.readAsString()) as Map<String, dynamic>;
        await db.query(
          'INSERT INTO compliance_findings (category, severity, message, metadata) VALUES (@category, @severity, @message, @metadata)',
          substitutionValues: {
            'category': payload['category'],
            'severity': payload['severity'],
            'message': payload['message'],
            'metadata': jsonEncode(payload['metadata'] ?? {}),
          },
        );
        return Response.ok(
          jsonEncode({'status': 'finding_registered'}),
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
      'compliance-api serving at http://${server.address.host}:${server.port}',
    );
  }
}
