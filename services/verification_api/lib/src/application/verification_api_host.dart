import 'package:server_core/server_core.dart';
import '../routes/verification_api_service_routes.dart';
// Governance - Category: service | Purpose: Base path /v4 as per legacy Hono app Placeholder for domain routes
import 'dart:io';
import 'package:shelf/shelf.dart';



class VerificationApiHost extends BaseCorsServiceHost {
  VerificationApiHost()
    : super(serviceName: 'verification-api', defaultPort: 8800);

  @override
  Future<Handler> createRoutes() async {
    return VerificationServiceRoutes().router.call;
  }

  @override
  void onStarted(HttpServer server) {
    print('Verification Service serving at http://0.0.0.0:${server.port}');
  }
}
