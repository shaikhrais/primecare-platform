import 'package:server_core/server_core.dart';
import 'package:shelf_router/shelf_router.dart';
import '../controllers/provider_api_http_controller.dart';

class ProviderServiceRoutes extends BaseApiRoutes {
  final ProviderHttpController controller;
  ProviderServiceRoutes(this.controller);

  @override
  void registerRoutes(Router router) {
    controller.registerRoutes(router);
  }
}
