import 'package:server_core/server_core.dart';
import 'dart:convert';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';
import '../repositories/provider_api_repository.dart';

class ProviderHttpController extends BaseController {
  final ProviderRepository repository;
  ProviderHttpController(this.repository);

  void registerRoutes(Router router) {

    router.get('/', (Request request) {
      return Response.ok(
        'Hello from provider-api (Hydrated with Dart DB Client)',
      );
    });

    // Fetch all providers
    router.get('/api/providers', (Request request) async {
      try {
        final results = await repository.listProviders();
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

    // Fetch provider by ID
    router.get('/api/providers/<id>', (Request request, String id) async {
      try {
        final results = await repository.findProvider(id);
        if (results.isEmpty) return Response.notFound('Provider not found');
        return Response.ok(
          jsonEncode(results.first),
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
