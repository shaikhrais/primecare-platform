import 'package:server_core/server_core.dart';
import '../controllers/billing_api_http_controller.dart';
import '../repositories/billing_api_repository.dart';
import '../routes/billing_api_service_routes.dart';
// Governance - Category: service | Purpose: Mount the 456 AI-generated routes Fetch all invoices
import 'dart:io';
import 'package:shelf/shelf.dart';
import 'package:database_client/database_client.dart';



class BillingApiHost extends BaseCorsServiceHost {
  BillingApiHost() : super(serviceName: 'billing-api', defaultPort: 8080);

  @override
  Future<Handler> createRoutes() async {
    final db = PlatformDatabase();
    await db.initialize();

    return BillingServiceRoutes(BillingHttpController(BillingRepository(db))).router.call;
  }

  @override
  void onStarted(HttpServer server) {
    print(
      'billing-api serving at http://${server.address.host}:${server.port}',
    );
  }
}
