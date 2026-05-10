import 'dart:io';
import 'dart:convert';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart';
import 'package:shelf_router/shelf_router.dart';
import 'package:shelf_cors_headers/shelf_cors_headers.dart';
import 'package:database_client/database_client.dart';

void main() async {
  final db = PlatformDatabase();
  await db.initialize();

  final router = Router();

  // Root route
  router.get('/', (Request request) {
    return Response.ok('Hello from client-api (Hydrated with Dart DB Client)');
  });

  // Fetch all clients
  router.get('/api/clients', (Request request) async {
    try {
      final results = await db.query('SELECT * FROM clients');
      return Response.ok(jsonEncode(results), headers: {'Content-Type': 'application/json'});
    } catch (e) {
      return Response.internalServerError(body: jsonEncode({'error': e.toString()}), headers: {'Content-Type': 'application/json'});
    }
  });

  // Add a new client
  router.post('/api/clients', (Request request) async {
    try {
      final payload = jsonDecode(await request.readAsString()) as Map<String, dynamic>;
      await db.query(
        'INSERT INTO clients (first_name, last_name, email) VALUES (@firstName, @lastName, @email)',
        substitutionValues: {
          'firstName': payload['first_name'],
          'lastName': payload['last_name'],
          'email': payload['email'],
        },
      );
      return Response.ok(jsonEncode({'status': 'success'}), headers: {'Content-Type': 'application/json'});
    } catch (e) {
      return Response.internalServerError(body: jsonEncode({'error': e.toString()}), headers: {'Content-Type': 'application/json'});
    }
  });

  final handler = const Pipeline()
      .addMiddleware(logRequests())
      .addMiddleware(corsHeaders())
      .addHandler(router.call);

  final port = int.parse(Platform.environment['PORT'] ?? '8080');
  final server = await serve(handler, InternetAddress.anyIPv4, port);
  print('client-api serving at http://${server.address.host}:${server.port}');
}
