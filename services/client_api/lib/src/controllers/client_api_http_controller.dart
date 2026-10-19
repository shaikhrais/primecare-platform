import 'package:server_core/server_core.dart';
import 'dart:convert';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';
import 'package:client_api/routes.dart';
import '../repositories/client_api_repository.dart';

class ClientHttpController extends BaseController {
  final ClientRepository repository;
  ClientHttpController(this.repository);

  void registerRoutes(Router router) {

    // Mount the 456 AI-generated routes
    final apiRoutes = ApiRoutes();
    router.mount('/', apiRoutes.router.call);

    // Root route
    router.get('/', (Request request) {
      return Response.ok(
        'Hello from client-api (Hydrated with Dart DB Client)',
      );
    });

    // Fetch all clients
    router.get('/api/clients', (Request request) async {
      try {
        final results = await repository.listClients();
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

    // Add a new client
    router.post('/api/clients', (Request request) async {
      try {
        final payload =
            jsonDecode(await request.readAsString()) as Map<String, dynamic>;
        await repository.createClient(payload);
        return Response.ok(
          jsonEncode({'status': 'success'}),
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
