import 'package:server_core/server_core.dart';
import 'package:shelf_router/shelf_router.dart';
import '../controllers/visit_api_http_controller.dart';

class VisitServiceRoutes extends BaseApiRoutes {
  final VisitHttpController controller;
  VisitServiceRoutes(this.controller);

  @override
  void registerRoutes(Router router) {
    controller.registerRoutes(router);
  }
}
