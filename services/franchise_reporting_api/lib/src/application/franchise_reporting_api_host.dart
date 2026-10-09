import 'package:server_core/server_core.dart';
import '../routes/franchise_reporting_api_service_routes.dart';
// Governance - Category: service | Purpose: Mount the 456 AI-generated routes
import 'dart:io';
import 'package:shelf/shelf.dart';



class FranchiseReportingApiHost extends BaseCorsServiceHost {
  FranchiseReportingApiHost()
    : super(serviceName: 'franchise-reporting-api', defaultPort: 8080);

  @override
  Future<Handler> createRoutes() async {
    return FranchiseReportingServiceRoutes().router.call;
  }

  @override
  void onStarted(HttpServer server) {
    print('franchise-reporting-api serving at http://0.0.0.0:${server.port}');
  }
}
