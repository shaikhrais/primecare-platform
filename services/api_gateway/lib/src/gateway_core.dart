import 'dart:io';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';
import 'package:shelf_proxy/shelf_proxy.dart';
import 'package:database_client/database_client.dart';
import 'mock_ui_service.dart';

/// [GatewayController] - Handles system-level gateway operations.
class GatewayController {
  final PlatformDatabase _db;

  GatewayController(this._db);

  Future<Response> healthCheck(Request request) async {
    try {
      await _db.query('SELECT 1');
      return Response.ok('{"status": "API Gateway Operational", "database": "healthy"}',
          headers: {'Content-Type': 'application/json'});
    } catch (e) {
      return Response.internalServerError(
          body: '{"status": "Gateway Degraded", "database": "offline"}',
          headers: {'Content-Type': 'application/json'});
    }
  }

  Future<Response> mockUI(Request request) => handleMockUIEndpoint(request);
}

/// [ServiceMesh] - Manages the configuration and proxying of microservices.
class ServiceMesh {
  final Map<String, String> services;

  ServiceMesh(this.services);

  factory ServiceMesh.fromEnvironment() {
    return ServiceMesh({
      'auth': Platform.environment['AUTH_SERVICE_URL'] ?? 'http://auth_api:8080',
      'providers': Platform.environment['PROVIDER_SERVICE_URL'] ?? 'http://provider_api:8080',
      'clients': Platform.environment['CLIENT_SERVICE_URL'] ?? 'http://client_api:8080',
      'billing': Platform.environment['BILLING_SERVICE_URL'] ?? 'http://billing_api:8080',
      'governance': Platform.environment['GOVERNANCE_SERVICE_URL'] ?? 'http://governance_api:8080',
      'verification': Platform.environment['VERIFICATION_SERVICE_URL'] ?? 'http://verification_api:8080',
      'compliance': Platform.environment['COMPLIANCE_SERVICE_URL'] ?? 'http://compliance_api:8080',
      'scheduling': Platform.environment['SCHEDULING_SERVICE_URL'] ?? 'http://scheduling_api:8080',
      'visits': Platform.environment['VISIT_SERVICE_URL'] ?? 'http://visit_api:8080',
    });
  }

  void registerRoutes(Router router) {
    services.forEach((key, url) {
      router.all('/api/$key/<ignored|.*>', proxyHandler(url));
    });
  }
}
