import 'package:shelf_router/shelf_router.dart';
import 'base_api_routes.dart';

/// A service composition root registers feature routes in their declared order.
/// Request identity, middleware and authorization remain at the service boundary.
abstract class BaseModularApiRoutes extends BaseApiRoutes {
  const BaseModularApiRoutes();

  Iterable<BaseApiRoutes> get modules;

  @override
  void registerRoutes(Router router) {
    for (final module in modules) {
      module.registerRoutes(router);
    }
  }
}
