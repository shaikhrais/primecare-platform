import 'package:shelf_router/shelf_router.dart';

/// Shared router construction for service-specific route bindings.
/// Each access creates a fresh router, matching the previous service getters.
abstract class BaseApiRoutes {
  const BaseApiRoutes();

  Router get router {
    final router = Router();
    registerRoutes(router);
    return router;
  }

  /// Register only existing routes; handlers retain their service behavior.
  void registerRoutes(Router router);
}
