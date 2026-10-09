import 'package:server_core/server_core.dart';
import 'package:shelf_router/shelf_router.dart';
import '../controllers/client_api_http_controller.dart';

class ClientServiceRoutes extends BaseApiRoutes {
  final ClientHttpController controller;
  ClientServiceRoutes(this.controller);

  @override
  void registerRoutes(Router router) {
    controller.registerRoutes(router);
  }
}
