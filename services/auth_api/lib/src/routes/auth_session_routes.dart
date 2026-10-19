import 'package:server_core/server_core.dart';
import 'package:shelf_router/shelf_router.dart';
import 'package:auth_api/routes.dart';
import '../controllers/auth_http_controller.dart';

class AuthSessionRoutes extends BaseApiRoutes {
  final AuthHttpController controller;
  AuthSessionRoutes(this.controller);

  @override
  void registerRoutes(Router router) {
    controller.registerRoutes(router);
    router.mount('/', ApiRoutes().router.call);
  }
}
