import 'package:server_core/server_core.dart';
import '../controllers/provider_api_http_controller.dart';
import '../repositories/provider_api_repository.dart';
import '../routes/provider_api_service_routes.dart';
// Governance - Category: service | Purpose: Fetch all providers
import 'dart:io';
import 'package:shelf/shelf.dart';
import 'package:database_client/database_client.dart';



class ProviderApiHost extends BaseCorsServiceHost {
  ProviderApiHost() : super(serviceName: 'provider-api', defaultPort: 8080);

  @override
  Future<Handler> createRoutes() async {
    final db = PlatformDatabase();
    await db.initialize();

    return ProviderServiceRoutes(ProviderHttpController(ProviderRepository(db))).router.call;
  }

  @override
  void onStarted(HttpServer server) {
    print(
      'provider-api serving at http://${server.address.host}:${server.port}',
    );
  }
}
