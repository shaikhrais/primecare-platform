// Governance - Category: service | Purpose: 1. Core Services Initialization 2. Route Registration (OOP Pattern) 3. UI Compatibility Layer
import 'dart:io';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart';
import 'package:shelf_router/shelf_router.dart';
import 'package:shelf_cors_headers/shelf_cors_headers.dart';
import 'package:database_client/database_client.dart';
import '../lib/src/gateway_core.dart';

void main() async {
  // 1. Core Services Initialization
  final db = PlatformDatabase();
  await db.initialize();

  final mesh = ServiceMesh.fromEnvironment();
  final controller = GatewayController(db);
  final router = Router();

  // 2. Route Registration (OOP Pattern)
  router.get('/health', controller.healthCheck);
  mesh.registerRoutes(router);

  // 3. Development-only UI compatibility layer. Production must never
  // silently return generated data for an unknown clinical endpoint.
  final mockUiEnabled =
      Platform.environment['ENABLE_MOCK_UI']?.toLowerCase() == 'true';
  if (mockUiEnabled) {
    router.all('/v1/<ignored|.*>', controller.mockUI);
    router.all('/dashboard/<ignored|.*>', controller.mockUI);
  }

  // 4. Middleware Pipeline
  final handler = const Pipeline()
      .addMiddleware(logRequests())
      .addMiddleware(corsHeaders(headers: {
        'Access-Control-Allow-Origin': Platform.environment['CORS_ALLOWED_ORIGIN'] ?? 'http://localhost:8085',
        'Access-Control-Allow-Credentials': 'true',
        'Access-Control-Allow-Methods': 'GET, POST, PUT, DELETE, OPTIONS',
        'Access-Control-Allow-Headers': 'Origin, Content-Type, Accept, Authorization, x-device-id, x-device-fingerprint, x-tenant-id, x-request-signature, x-requested-signature, x-requested-with, x-app-version, x-api-key',
      }))
      .addHandler(router.call);

  // 5. Server Startup
  final port = int.parse(Platform.environment['PORT'] ?? '8700');
  final server = await serve(handler, InternetAddress.anyIPv4, port);
  print('=========================================');
  print('PrimeCare API Gateway (Max OOP)');
  print('Address: http://${server.address.host}:${server.port}');
  print('Services: ${mesh.services.keys.join(', ')}');
  print('=========================================');
}
