import 'package:server_core/server_core.dart';
import '../controllers/scheduling_api_http_controller.dart';
import '../repositories/scheduling_api_repository.dart';
import '../routes/scheduling_api_service_routes.dart';
// Governance - Category: service | Purpose: Mount the 456 AI-generated routes Fetch all schedules with Client and Provider names (JOIN Example)
import 'dart:io';
import 'package:shelf/shelf.dart';
import 'package:database_client/database_client.dart';



class SchedulingApiHost extends BaseCorsServiceHost {
  SchedulingApiHost() : super(serviceName: 'scheduling-api', defaultPort: 8080);

  @override
  Future<Handler> createRoutes() async {
    final db = PlatformDatabase();
    await db.initialize();

    return SchedulingServiceRoutes(SchedulingHttpController(SchedulingRepository(db))).router.call;
  }

  @override
  void onStarted(HttpServer server) {
    print(
      'scheduling-api serving at http://${server.address.host}:${server.port}',
    );
  }
}
