import 'package:server_core/server_core.dart';
import 'package:shelf_router/shelf_router.dart';
import '../controllers/compliance_api_http_controller.dart';

class ComplianceServiceRoutes extends BaseApiRoutes {
  final ComplianceHttpController controller;
  ComplianceServiceRoutes(this.controller);

  @override
  void registerRoutes(Router router) {
    controller.registerRoutes(router);
  }
}
