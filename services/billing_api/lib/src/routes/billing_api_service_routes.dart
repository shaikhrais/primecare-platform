import 'package:server_core/server_core.dart';
import 'package:shelf_router/shelf_router.dart';
import '../controllers/billing_api_http_controller.dart';

class BillingServiceRoutes extends BaseApiRoutes {
  final BillingHttpController controller;
  BillingServiceRoutes(this.controller);

  @override
  void registerRoutes(Router router) {
    controller.registerRoutes(router);
  }
}
