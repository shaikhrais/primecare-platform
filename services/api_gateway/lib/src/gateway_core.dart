import 'dart:io';
import 'package:shelf/shelf.dart' as shelf;
import 'package:shelf_router/shelf_router.dart';

import 'package:http/http.dart' as http;
import 'package:database_client/database_client.dart';
import 'mock_ui_service.dart';

/// [GatewayController] - Handles system-level gateway operations.
class GatewayController {
  final PlatformDatabase _db;

  GatewayController(this._db);

  Future<shelf.Response> healthCheck(shelf.Request request) async {
    try {
      await _db.query('SELECT 1');
      return shelf.Response.ok('{"status": "API Gateway Operational", "database": "healthy"}',
          headers: {'Content-Type': 'application/json'});
    } catch (e) {
      return shelf.Response.internalServerError(
          body: '{"status": "Gateway Degraded", "database": "offline"}',
          headers: {'Content-Type': 'application/json'});
    }
  }

  Future<shelf.Response> mockUI(shelf.Request request) => handleMockUIEndpoint(request);
}

/// [ServiceMesh] - Manages the configuration and proxying of microservices.
class ServiceMesh {
  final Map<String, String> services;

  ServiceMesh(this.services);

  factory ServiceMesh.fromEnvironment() {
    return ServiceMesh({
      'auth': Platform.environment['AUTH_SERVICE_URL'] ?? 'http://localhost:8081',
      'providers': Platform.environment['PROVIDER_SERVICE_URL'] ?? 'http://localhost:8082',
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
      print('Registering route: /v1/$key/ to $url');
      
      final handler = (shelf.Request request) async {
        final remainingPath = request.params['path'] ?? '';
        final targetUrl = '$url/$remainingPath';
        
        print('Manual Proxying ${request.method} ${request.requestedUri.path} to $targetUrl');
        
        try {
          final client = http.Client();
          final body = await request.read().fold<List<int>>(<int>[], (p, e) => p..addAll(e));
          
          final proxiedRequest = http.Request(request.method, Uri.parse(targetUrl))
            ..headers.addAll(request.headers)
            ..bodyBytes = body;
          
          // Remove host header to avoid conflicts
          proxiedRequest.headers.remove('host');
          
          final streamedResponse = await client.send(proxiedRequest);
          final response = await http.Response.fromStream(streamedResponse);
          
          return shelf.Response(
            response.statusCode,
            body: response.bodyBytes,
            headers: response.headers,
          );
        } catch (e) {
          print('Proxy Error: $e');
          return shelf.Response.internalServerError(body: 'Proxy Error: $e');
        }
      };

      router.all('/api/$key/<path|.*>', handler);
      router.all('/v1/$key/<path|.*>', handler);
    });
  }
}
