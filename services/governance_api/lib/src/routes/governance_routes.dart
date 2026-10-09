import 'package:shelf_router/shelf_router.dart';
import '../controllers/governance_controller.dart';
import 'governance_api_routes.dart';

/// Compatibility entrypoint; controller creation stays lazy until a request.
class GovernanceRoutes {
  static Router get router => GovernanceApiRoutes(() => GovernanceController.instance).router;
}
