import 'package:server_core/server_core.dart';
import '../controllers/visit_api_http_controller.dart';
import '../repositories/visit_api_repository.dart';
import '../routes/visit_api_service_routes.dart';
// Governance - Category: service | Purpose: Fetch all clinical visits
import 'dart:io';
import 'package:shelf/shelf.dart';
import 'package:database_client/database_client.dart';



class VisitApiHost extends BaseCorsServiceHost {
  VisitApiHost() : super(serviceName: 'visit-api', defaultPort: 8080);

  @override
  Future<Handler> createRoutes() async {
    final db = PlatformDatabase();
    await db.initialize();

    return VisitServiceRoutes(VisitHttpController(VisitRepository(db))).router.call;
  }

  @override
  void onStarted(HttpServer server) {
    print('visit-api serving at http://${server.address.host}:${server.port}');
  }
}
