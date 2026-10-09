import 'package:server_core/server_core.dart';
// Governance - Category: service | Purpose: Mount the 456 AI-generated routes
import 'dart:io';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';
import 'package:franchise_reporting_api/routes.dart';

Future<void> main() async {
  await FranchiseReportingApiHost().run();
}

class FranchiseReportingApiHost extends BaseCorsServiceHost {
  FranchiseReportingApiHost()
    : super(serviceName: 'franchise-reporting-api', defaultPort: 8080);

  @override
  Future<Handler> createRoutes() async {
    final router = Router();

    // Mount the 456 AI-generated routes
    final apiRoutes = ApiRoutes();
    router.mount('/', apiRoutes.router.call);
    router.get(
      '/',
      (Request request) =>
          Response.ok('Hello from franchise-reporting-api (Migrated to Dart)'),
    );
    return router.call;
  }

  @override
  void onStarted(HttpServer server) {
    print('franchise-reporting-api serving at http://0.0.0.0:${server.port}');
  }
}
