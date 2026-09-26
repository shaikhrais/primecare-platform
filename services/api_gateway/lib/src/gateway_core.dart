// Governance - Category: service | Purpose: [GatewayController] - Handles system-level gateway operations.
import 'dart:io';
import 'dart:async';
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
  final http.Client _client;

  ServiceMesh(this.services, {http.Client? client}) : _client = client ?? http.Client();

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
      print('Registering route: /v1/$key/ to $url');
      
      final handler = (shelf.Request request) async {
        final remainingPath = request.params['path'] ?? '';
        final upstream = Uri.parse(url);
        final target = upstream.replace(
          pathSegments: [...upstream.pathSegments.where((part) => part.isNotEmpty),
            ...remainingPath.split('/').where((part) => part.isNotEmpty)],
          query: request.requestedUri.hasQuery ? request.requestedUri.query : null,
        );

        try {
          final proxiedRequest = http.StreamedRequest(request.method, target);
          for (final entry in request.headers.entries) {
            if (!const {'host', 'connection', 'transfer-encoding', 'content-length'}
                .contains(entry.key.toLowerCase())) {
              proxiedRequest.headers[entry.key] = entry.value;
            }
          }
          await proxiedRequest.sink.addStream(request.read());
          await proxiedRequest.sink.close();

          final upstreamResponse = await _client.send(proxiedRequest)
              .timeout(const Duration(seconds: 30));
          final responseHeaders = Map<String, String>.from(upstreamResponse.headers)
            ..removeWhere((key, value) =>
                const {'connection', 'transfer-encoding', 'content-length'}
                    .contains(key.toLowerCase()));
          return shelf.Response(
            upstreamResponse.statusCode,
            body: upstreamResponse.stream,
            headers: responseHeaders,
          );
        } on TimeoutException {
          return shelf.Response(504, body: 'Upstream service timed out');
        } catch (_) {
          return shelf.Response(502, body: 'Upstream service unavailable');
        }
      };

      router.all('/api/$key/<path|.*>', handler);
      router.all('/v1/$key/<path|.*>', handler);
    });
  }
}
