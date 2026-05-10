import 'dart:io';
import 'dart:convert';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart';
import 'package:shelf_router/shelf_router.dart';
import 'package:shelf_cors_headers/shelf_cors_headers.dart';
import 'package:database_client/database_client.dart';

// The migrated Auth API with DB Hydration
void main() async {
  final db = PlatformDatabase();
  await db.initialize();

  final router = Router();

  // Root route
  router.get('/', (Request request) {
    return Response.ok('Hello from auth-service (Hydrated with Dart DB Client)');
  });

  // Login route (Example of DB interaction)
  router.post('/login', (Request request) async {
    final payload = jsonDecode(await request.readAsString());
    final email = payload['email'];

    // Real DB Query using the shared client
    final results = await db.query(
      'SELECT id, roles FROM users WHERE email = @email LIMIT 1',
      substitutionValues: {'email': email},
    );

    if (results.isEmpty) {
      return Response.forbidden('{"error": "User not found"}', headers: {'Content-Type': 'application/json'});
    }

    final user = results.first;
    return Response.ok(jsonEncode({
      'userId': user[0],
      'roles': user[1],
      'status': 'authenticated',
    }), headers: {'Content-Type': 'application/json'});
  });

  // Health check
  router.get('/health', (Request request) {
    return Response.ok('{"status": "healthy", "database": "connected"}', headers: {'Content-Type': 'application/json'});
  });

  final handler = const Pipeline()
      .addMiddleware(logRequests())
      .addMiddleware(corsHeaders())
      .addHandler(router.call);

  final port = int.parse(Platform.environment['PORT'] ?? '8080');
  final server = await serve(handler, InternetAddress.anyIPv4, port);
  print('Auth API serving at http://${server.address.host}:${server.port}');
}
