import 'package:server_core/server_core.dart';
import '../controllers/compliance_api_http_controller.dart';
import '../repositories/compliance_api_repository.dart';
import '../routes/compliance_api_service_routes.dart';
// Governance - Category: service | Purpose: Mount the 456 AI-generated routes Fetch compliance audits
import 'dart:io';
import 'package:shelf/shelf.dart';
import 'package:database_client/database_client.dart';



class ComplianceApiHost extends BaseCorsServiceHost {
  ComplianceApiHost() : super(serviceName: 'compliance-api', defaultPort: 8080);

  @override
  Future<Handler> createRoutes() async {
    final db = PlatformDatabase();
    await db.initialize();

    return ComplianceServiceRoutes(ComplianceHttpController(ComplianceRepository(db))).router.call;
  }

  @override
  void onStarted(HttpServer server) {
    print(
      'compliance-api serving at http://${server.address.host}:${server.port}',
    );
  }
}
