import 'package:server_core/server_core.dart';
import 'dart:convert';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';
import 'package:billing_api/routes.dart';
import '../repositories/billing_api_repository.dart';

class BillingHttpController extends BaseController {
  final BillingRepository repository;
  BillingHttpController(this.repository);

  void registerRoutes(Router router) {

    // Mount the 456 AI-generated routes
    final apiRoutes = ApiRoutes();
    router.mount('/', apiRoutes.router.call);

    router.get('/', (Request request) {
      return Response.ok(
        'Hello from billing-api (Hydrated with Dart DB Client)',
      );
    });

    // Fetch all invoices
    router.get('/api/invoices', (Request request) async {
      try {
        final results = await repository.listInvoices();
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
