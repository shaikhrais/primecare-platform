import 'package:server_core/server_core.dart';
// Governance - Category: service | Purpose: Base path /v4 as per legacy Hono app Placeholder for domain routes
import 'dart:io';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

Future<void> main() async {
  await VerificationApiHost().run();
}

class VerificationApiHost extends BaseCorsServiceHost {
  VerificationApiHost()
    : super(serviceName: 'verification-api', defaultPort: 8800);

  @override
  Future<Handler> createRoutes() async {
    final router = Router();

    // Base path /v4 as per legacy Hono app
    final v4Router = Router();

    v4Router.get('/health', (Request request) {
      return Response.ok(
        '{"status": "ok", "service": "primecare-verification-service (Dart)"}',
        headers: {'Content-Type': 'application/json'},
      );
    });

    // Placeholder for domain routes
    final domains = [
      'identity',
      'finance',
      'audit',
      'admin',
      'clinical',
      'compliance',
      'user',
      'auth',
      'system',
      'dashboard',
    ];
    for (var domain in domains) {
      v4Router.all('/$domain/<ignored|.*>', (Request request) {
        return Response.ok(
          '{"message": "$domain domain via Dart Verification Service"}',
          headers: {'Content-Type': 'application/json'},
        );
      });
    }

    router.mount('/v4/', v4Router.call);

    return router.call;
  }

  @override
  void onStarted(HttpServer server) {
    print('Verification Service serving at http://0.0.0.0:${server.port}');
  }
}
