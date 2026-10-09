import 'package:server_core/server_core.dart';
import 'dart:convert';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';
import '../repositories/visit_api_repository.dart';

class VisitHttpController extends BaseController {
  final VisitRepository repository;
  VisitHttpController(this.repository);

  void registerRoutes(Router router) {

    router.get('/', (Request request) {
      return Response.ok('Hello from visit-api (Hydrated with Dart DB Client)');
    });

    // Fetch all clinical visits
    router.get('/api/visits', (Request request) async {
      try {
        final results = await repository.listVisits();
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

    // Start a new visit
    router.post('/api/visits', (Request request) async {
      try {
        final payload =
            jsonDecode(await request.readAsString()) as Map<String, dynamic>;
        await repository.createVisit(payload);
        return Response.ok(
          jsonEncode({'status': 'visit_created'}),
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
