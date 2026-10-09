import 'package:server_core/server_core.dart';
import 'dart:convert';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';
import 'package:compliance_api/routes.dart';
import '../repositories/compliance_api_repository.dart';

class ComplianceHttpController extends BaseController {
  final ComplianceRepository repository;
  ComplianceHttpController(this.repository);

  void registerRoutes(Router router) {

    // Mount the 456 AI-generated routes
    final apiRoutes = ApiRoutes();
    router.mount('/', apiRoutes.router.call);

    router.get('/', (Request request) {
      return Response.ok(
        'Hello from compliance-api (Hydrated with Dart DB Client)',
      );
    });

    // Fetch compliance audits
    router.get('/api/compliance/audits', (Request request) async {
      try {
        final results = await repository.listAudits();
        return Response.ok(
          jsonEncode(results),
          headers: {'Content-Type': 'application/json'},
        );
      } catch (e) {
        return Response.internalServerError(
          body: jsonEncode({'error': e.toString()}),
          headers: {'Content-Type': 'application/json'},
        );
      }
    });

    // Register a new compliance finding
    router.post('/api/compliance/findings', (Request request) async {
      try {
        final payload =
            jsonDecode(await request.readAsString()) as Map<String, dynamic>;
        await repository.createFinding(payload);
        return Response.ok(
          jsonEncode({'status': 'finding_registered'}),
          headers: {'Content-Type': 'application/json'},
        );
      } catch (e) {
        return Response.internalServerError(
          body: jsonEncode({'error': e.toString()}),
          headers: {'Content-Type': 'application/json'},
        );
      }
    });


  }
}
