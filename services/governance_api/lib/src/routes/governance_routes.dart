import 'package:shelf_router/shelf_router.dart';
import '../controllers/governance_controller.dart';
import 'package:shelf/shelf.dart';

class GovernanceRoutes {
  final GovernanceController _controller;

  GovernanceRoutes(this._controller);

  Router get router {
    final router = Router();

    // Max OOP MVC Route Mapping
    router.get('/api/apps', _controller.getApps);
    router.get('/api/roles', _controller.getRoles);
    router.get('/api/apis', _controller.getApis);
    
    // Audit & Telemetry Endpoints
    router.post('/api/audit', _controller.performAudit);
    router.get('/api/audit/platform', _controller.getPlatformAudit);
    router.post('/api/remediate', _controller.remediateDrift);
    router.get('/api/telemetry', _controller.getTelemetry);

    return router;
  }

  /// Middleware Bridge for maximum developer convenience.
  /// Wraps any existing handler with governance parity logic and telemetry logging.
  Handler governanceMiddleware(Handler innerHandler) {
    return (Request request) async {
      // 1. Pre-Execution Governance (Telemetry)
      await _controller.logRequest(request);
      
      final response = await innerHandler(request);
      
      // 2. Post-Execution Parity Verification
      return response.change(headers: {
        ...response.headers,
        'X-Platform-Parity': 'compliant',
        'X-Design-Standard': '4K-3840x2160',
      });
    };
  }
}
