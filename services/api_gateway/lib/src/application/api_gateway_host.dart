import 'package:server_core/server_core.dart';
// Governance - Category: service | Purpose: 1. Core Services Initialization 2. Route Registration (OOP Pattern) 3. UI Compatibility Layer
import 'dart:io';
import 'package:shelf/shelf.dart';
import 'package:shelf_cors_headers/shelf_cors_headers.dart';
import 'package:database_client/database_client.dart';
import '../gateway_core.dart';
import '../routes/gateway_api_routes.dart';



class ApiGatewayHost extends BaseHttpServiceHost {
  late ServiceMesh mesh;
  ApiGatewayHost() : super(serviceName: 'api-gateway', defaultPort: 8700);

  @override
  Future<Handler> createRoutes() async {
    // 1. Core Services Initialization
    final db = PlatformDatabase();
    await db.initialize();

    mesh = ServiceMesh.fromEnvironment();
    final controller = GatewayController(db);
    return GatewayApiRoutes(mesh, controller).router.call;
  }

  @override
  List<Middleware> get middleware => [
    logRequests(),
    corsHeaders(
      headers: {
        'Access-Control-Allow-Origin':
            Platform.environment['CORS_ALLOWED_ORIGIN'] ??
            'http://localhost:8085',
        'Access-Control-Allow-Credentials': 'true',
        'Access-Control-Allow-Methods': 'GET, POST, PUT, DELETE, OPTIONS',
        'Access-Control-Allow-Headers':
            'Origin, Content-Type, Accept, Authorization, x-device-id, x-device-fingerprint, x-tenant-id, x-request-signature, x-requested-signature, x-requested-with, x-app-version, x-api-key',
      },
    ),
  ];

  @override
  void onStarted(HttpServer server) {
    print('=========================================');
    print('PrimeCare API Gateway (Max OOP)');
    print('Address: http://${server.address.host}:${server.port}');
    print('Services: ${mesh.services.keys.join(', ')}');
    print('=========================================');
  }
}
