import 'package:server_core/server_core.dart';
import 'package:shelf_router/shelf_router.dart';
import '../controllers/scheduling_api_http_controller.dart';

class SchedulingServiceRoutes extends BaseApiRoutes {
  final SchedulingHttpController controller;
  SchedulingServiceRoutes(this.controller);

  @override
  void registerRoutes(Router router) {
    controller.registerRoutes(router);
  }
}
