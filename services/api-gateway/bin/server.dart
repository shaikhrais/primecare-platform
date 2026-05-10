import 'dart:io';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart';
import 'package:shelf_router/shelf_router.dart';
import 'package:shelf_proxy/shelf_proxy.dart';
import 'package:shelf_cors_headers/shelf_cors_headers.dart';
import 'package:database_client/database_client.dart';
import '../lib/src/mock_ui_service.dart';

void main() async {
  final db = PlatformDatabase();
  await db.initialize();

  final router = Router();

  // Service Mesh Configuration (Environment Variable Driven)
  final services = {
    'auth': Platform.environment['AUTH_SERVICE_URL'] ?? 'http://auth-api:8080',
    'providers': Platform.environment['PROVIDER_SERVICE_URL'] ?? 'http://provider-api:8080',
    'clients': Platform.environment['CLIENT_SERVICE_URL'] ?? 'http://client-api:8080',
    'billing': Platform.environment['BILLING_SERVICE_URL'] ?? 'http://billing-api:8080',
    'governance': Platform.environment['GOVERNANCE_SERVICE_URL'] ?? 'http://governance-api:8080',
    'compliance': Platform.environment['COMPLIANCE_SERVICE_URL'] ?? 'http://compliance-api:8080',
    'scheduling': Platform.environment['SCHEDULING_SERVICE_URL'] ?? 'http://scheduling-api:8080',
    'visits': Platform.environment['VISIT_SERVICE_URL'] ?? 'http://visit-api:8080',
  };

  // Health check with DB status
  router.get('/health', (Request request) async {
    try {
      await db.query('SELECT 1');
      return Response.ok('{"status": "API Gateway Operational", "database": "healthy"}',
          headers: {'Content-Type': 'application/json'});
    } catch (e) {
      return Response.internalServerError(body: '{"status": "Gateway Degraded", "database": "offline"}',
          headers: {'Content-Type': 'application/json'});
    }
  });

  // Service Mesh Proxy Handlers
  services.forEach((key, url) {
    router.all('/api/$key/<ignored|.*>', proxyHandler(url));
  });

  // UI Compatibility Layer: Mock interceptor
  router.all('/v1/<ignored|.*>', handleMockUIEndpoint);
  router.all('/dashboard/<ignored|.*>', handleMockUIEndpoint);

  final handler = const Pipeline()
      .addMiddleware(logRequests())
      .addMiddleware(corsHeaders())
      .addHandler(router.call);

  final port = int.parse(Platform.environment['PORT'] ?? '8700');
  final server = await serve(handler, InternetAddress.anyIPv4, port);
  print('API Gateway serving at http://${server.address.host}:${server.port}');
}
