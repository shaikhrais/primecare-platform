import 'package:server_core/server_core.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';
import 'package:franchise_reporting_api/routes.dart';

class FranchiseReportingServiceRoutes extends BaseApiRoutes {
  @override
  void registerRoutes(Router router) {

    // Mount the 456 AI-generated routes
    final apiRoutes = ApiRoutes();
    router.mount('/', apiRoutes.router.call);
    router.get(
      '/',
      (Request request) =>
          Response.ok('Hello from franchise-reporting-api (Migrated to Dart)'),
    );

  }
}
