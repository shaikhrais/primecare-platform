import 'dart:io';
import 'package:server_core/server_core.dart';
import 'package:shelf/shelf.dart';
import 'package:database_client/database_client.dart';
import '../routes/auth_session_routes.dart';
import '../controllers/auth_http_controller.dart';
import '../repositories/auth_repository.dart';

class AuthApiHost extends BaseHttpServiceHost {
  AuthApiHost() : super(serviceName: 'auth-api', defaultPort: 8080);

  @override
  Future<Handler> createRoutes() async {
    final db = PlatformDatabase();
    await db.initialize();
    return AuthSessionRoutes(AuthHttpController(AuthRepository(db))).router.call;
  }

  @override
  void onStarted(HttpServer server) {
    print('Auth API serving at port ${server.port}');
  }
}
