import 'dart:io';
import 'dart:convert';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart';
import 'package:shelf_router/shelf_router.dart';
import 'package:auth_api/routes.dart';
import 'package:shelf_cors_headers/shelf_cors_headers.dart';
import 'package:database_client/database_client.dart';

// The migrated Auth API with DB Hydration
void main() async {
  final db = PlatformDatabase();
  await db.initialize();

  final router = Router();

  // Mount the 456 AI-generated routes
  final apiRoutes = ApiRoutes();
  router.mount('/', apiRoutes.router.call);

  // Root route
  router.get('/', (Request request) {
    return Response.ok('Hello from auth-service (Hydrated with Dart DB Client)');
  });

  // Login route (Example of DB interaction)
  router.post('/login', (Request request) async {
    final payload = jsonDecode(await request.readAsString()) as Map<String, dynamic>;
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
    
    // Set cookie for SSO across subdomains
    // Domain=.primecare.com is crucial for primecare_clinic and primecare_corporate to share it.
    final token = user[0]; // For demo, using ID as token. In reality, a JWT.
    final cookie = 'session_token=$token; Domain=.primecare.com; Path=/; HttpOnly; SameSite=Lax';

    return Response.ok(jsonEncode({
      'userId': user[0],
      'roles': user[1],
      'token': token,
      'status': 'authenticated',
    }), headers: {
      'Content-Type': 'application/json',
      'Set-Cookie': cookie,
    });
  });

  // /me route to restore session using cookie
  router.get('/me', (Request request) async {
    final cookieHeader = request.headers['cookie'];
    if (cookieHeader == null || !cookieHeader.contains('session_token=')) {
      return Response.forbidden('{"error": "No session"}', headers: {'Content-Type': 'application/json'});
    }

    // Extract token
    final tokenMatch = RegExp(r'session_token=([^;]+)').firstMatch(cookieHeader);
    final token = tokenMatch?.group(1);

    if (token == null) {
      return Response.forbidden('{"error": "Invalid session"}', headers: {'Content-Type': 'application/json'});
    }

    // Mock validation against DB (using token as userId for demo)
    final results = await db.query(
      'SELECT id, roles FROM users WHERE id = @id LIMIT 1',
      substitutionValues: {'id': token},
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
      .addMiddleware(corsHeaders(headers: {
        'Access-Control-Allow-Origin': 'https://auth.primecare.com', // Or dynamically read from origin
        'Access-Control-Allow-Credentials': 'true',
        'Access-Control-Allow-Headers': 'Origin, Content-Type, Accept, Authorization',
      }))
      .addHandler(router.call);

  final port = int.parse(Platform.environment['PORT'] ?? '8080');
  final server = await serve(handler, InternetAddress.anyIPv4, port);
  print('Auth API serving at http://${server.address.host}:${server.port}');
}
