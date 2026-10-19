import 'package:server_core/server_core.dart';
import '../routes/notification_api_service_routes.dart';
// Governance - Category: service | Purpose: Edge API service engine running request listeners and background worker micro-tasks.
import 'dart:io';
import 'package:shelf/shelf.dart';



class NotificationApiHost extends BaseCorsServiceHost {
  NotificationApiHost()
    : super(serviceName: 'notification-api', defaultPort: 8080);

  @override
  Future<Handler> createRoutes() async {
    return NotificationServiceRoutes().router.call;
  }

  @override
  void onStarted(HttpServer server) {
    print('notification-api serving at http://0.0.0.0:${server.port}');
  }
}
