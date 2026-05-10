import 'dart:io';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart';
import 'package:governance_api/src/database/database_controller.dart';
import 'package:governance_api/src/routes/governance_routes.dart';
import 'package:governance_api/src/controllers/governance_controller.dart';
import 'package:governance_api/src/repositories/governance_repository.dart';
import 'package:governance_api/src/core/subsystem_scanner.dart';

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

void main(List<String> args) async {
  // 1. Initialize Database & Run Migrations
  print('Initializing database...');
  await DatabaseController.initialize();
  print('Database initialized.');

  // 2. Max OOP MVC Injection (The "Max" part)
  // Dependency Flow: Scanner + Connection -> Repository -> Controller -> Routes
  final scanner = SubsystemScanner();
  final repository = GovernanceRepository(DatabaseController.connection);
  final controller = GovernanceController(repository, scanner);
  final routes = GovernanceRoutes(controller);

  // 3. Configure Pipeline
  final ip = InternetAddress.anyIPv4;
  final handler = Pipeline()
      .addMiddleware(corsMiddleware())
      .addMiddleware(logRequests())
      // Apply the instance-based middleware for baseline parity enforcement and telemetry
      .addMiddleware(routes.governanceMiddleware)
      .addHandler(routes.router.call);

  // 4. Start Server
  final port = int.parse(Platform.environment['PORT'] ?? '8080');
  final server = await serve(handler, ip, port);
  print('Governance Service listening on port ${server.port}');
}
