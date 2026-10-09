import 'package:server_core/server_core.dart';
import 'package:shelf/shelf.dart' as shelf;
import 'package:database_client/database_client.dart';
import '../repositories/gateway_repository.dart';
import '../mock_ui_service.dart';

/// [GatewayController] - Handles system-level gateway operations.
class GatewayController extends BaseController {
  final GatewayRepository _repository;

  GatewayController(PlatformDatabase database)
      : _repository = GatewayRepository(database);

  Future<shelf.Response> healthCheck(shelf.Request request) async {
    try {
      await _repository.checkHealth();
      return shelf.Response.ok('{"status": "API Gateway Operational", "database": "healthy"}',
          headers: {'Content-Type': 'application/json'});
    } catch (e) {
      return shelf.Response.internalServerError(
          body: '{"status": "Gateway Degraded", "database": "offline"}',
          headers: {'Content-Type': 'application/json'});
    }
  }

  Future<shelf.Response> mockUI(shelf.Request request) => handleMockUIEndpoint(request);
}
