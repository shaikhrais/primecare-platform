import 'package:server_core/server_core.dart';
// Governance - Category: service | Purpose: Helper to add CORS headers
import 'dart:io';
import 'package:shelf/shelf.dart';
import 'package:governance_api/src/database/database_controller.dart';
import 'package:governance_api/src/routes/governance_routes.dart';

// Helper to add CORS headers
Middleware corsMiddleware() {
  return (Handler innerHandler) {
    return (Request request) async {
      if (request.method == 'OPTIONS') {
        return Response.ok(
          '',
          headers: {
            'Access-Control-Allow-Origin': '*',
            'Access-Control-Allow-Methods': 'GET, POST, PUT, DELETE, OPTIONS',
            'Access-Control-Allow-Headers': 'Origin, Content-Type, Accept',
          },
        );
      }

      final response = await innerHandler(request);
      return response.change(headers: {'Access-Control-Allow-Origin': '*'});
    };
  };
}

Future<void> main(List<String> args) async {
  await GovernanceApiHost().run();
}

class GovernanceApiHost extends BaseHttpServiceHost {
  GovernanceApiHost() : super(serviceName: 'governance-api', defaultPort: 8080);

  @override
  Future<Handler> createRoutes() async {
    // 1. Initialize Database & Run Migrations
    print('Initializing database...');
    await DatabaseController.initialize();
    print('Database initialized.');

    // 2. Setup Routing
    final router = GovernanceRoutes.router;

    // 3. Configure Pipeline
    return router.call;
  }

  @override
  List<Middleware> get middleware => [corsMiddleware(), logRequests()];

  @override
  void onStarted(HttpServer server) {
    print('Governance Service listening on port ${server.port}');
  }
}
