import 'package:server_core/server_core.dart';
import '../controllers/client_api_http_controller.dart';
import '../repositories/client_api_repository.dart';
import '../routes/client_api_service_routes.dart';
// Governance - Category: service | Purpose: Mount the 456 AI-generated routes Root route
import 'dart:io';
import 'package:shelf/shelf.dart';
import 'package:database_client/database_client.dart';



class ClientApiHost extends BaseCorsServiceHost {
  ClientApiHost() : super(serviceName: 'client-api', defaultPort: 8080);

  @override
  Future<Handler> createRoutes() async {
    final db = PlatformDatabase();
    await db.initialize();

    return ClientServiceRoutes(ClientHttpController(ClientRepository(db))).router.call;
  }

  @override
  void onStarted(HttpServer server) {
    print('client-api serving at http://${server.address.host}:${server.port}');
  }
}
