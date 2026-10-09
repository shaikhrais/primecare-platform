import 'package:server_core/server_core.dart';
import 'dart:convert';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';
import 'package:scheduling_api/routes.dart';
import '../repositories/scheduling_api_repository.dart';

class SchedulingHttpController extends BaseController {
  final SchedulingRepository repository;
  SchedulingHttpController(this.repository);

  void registerRoutes(Router router) {

    // Mount the 456 AI-generated routes
    final apiRoutes = ApiRoutes();
    router.mount('/', apiRoutes.router.call);

    router.get('/', (Request request) {
      return Response.ok(
        'Hello from scheduling-api (Hydrated with Dart DB Client)',
      );
    });

    // Fetch all schedules with Client and Provider names (JOIN Example)
    router.get('/api/schedules', (Request request) async {
      try {
        final results = await repository.listSchedules();
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


  }
}
