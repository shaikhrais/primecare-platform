import 'dart:io';
import 'package:server_core/server_core.dart';
import 'package:shelf_router/shelf_router.dart';
import '../controllers/gateway_controller.dart';
import '../infrastructure/service_mesh.dart';

class GatewayApiRoutes extends BaseApiRoutes {
  final ServiceMesh mesh;
  final GatewayController controller;
  GatewayApiRoutes(this.mesh, this.controller);

  @override
  void registerRoutes(Router router) {

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
  }
}
