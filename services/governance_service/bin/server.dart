import 'dart:convert';
import 'dart:io';

import 'package:postgres/postgres.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart';
import 'package:shelf_router/shelf_router.dart';

// Helper to add CORS headers
Middleware corsMiddleware() {
  return (Handler innerHandler) {
    return (Request request) async {
      if (request.method == 'OPTIONS') {
        return Response.ok(
          '',
          headers: {
            'Access-Control-Allow-Origin': '*',
            'Access-Control-Allow-Methods': 'GET, POST, PUT, DELETE, OPTIONS',
            'Access-Control-Allow-Headers': 'Origin, Content-Type, Accept',
          },
        );
      }

      final response = await innerHandler(request);
      return response.change(headers: {'Access-Control-Allow-Origin': '*'});
    };
  };
}

Future<Connection> _getDbConnection() async {
  final dbUrl =
      Platform.environment['DATABASE_URL'] ??
      'postgresql://postgres:password@localhost:5432/primecare';
  final uri = Uri.parse(dbUrl);

  final userInfo = uri.userInfo.split(':');
  final username = userInfo.isNotEmpty ? userInfo[0] : 'postgres';
  final password = userInfo.length > 1 ? userInfo[1] : 'password';

  return await Connection.open(
    Endpoint(
      host: uri.host,
      port: uri.port,
      database: uri.pathSegments.isNotEmpty
          ? uri.pathSegments.first
          : 'primecare',
      username: username,
      password: password,
    ),
    settings: ConnectionSettings(sslMode: SslMode.disable),
  );
}

void main(List<String> args) async {
  // Initialize the database
  final db = await _getDbConnection();

  await db.execute('''
    CREATE TABLE IF NOT EXISTS apps (
      id SERIAL PRIMARY KEY,
      name TEXT NOT NULL,
      type TEXT NOT NULL,
      status TEXT NOT NULL
    );
  ''');

  await db.execute('''
    CREATE TABLE IF NOT EXISTS roles (
      id SERIAL PRIMARY KEY,
      name TEXT NOT NULL,
      code TEXT NOT NULL,
      status TEXT NOT NULL
    );
  ''');

  await db.execute('''
    CREATE TABLE IF NOT EXISTS modules (
      id SERIAL PRIMARY KEY,
      name TEXT NOT NULL,
      app_id TEXT,
      priority TEXT NOT NULL
    );
  ''');

  await db.execute('''
    CREATE TABLE IF NOT EXISTS features (
      id SERIAL PRIMARY KEY,
      requested_by TEXT NOT NULL,
      feature_name TEXT NOT NULL,
      intent TEXT NOT NULL,
      app_name TEXT NOT NULL,
      screens TEXT,
      apis TEXT,
      roles TEXT,
      status TEXT NOT NULL
    );
  ''');

  final router = Router();

  router.get('/api/apps', (Request req) async {
    final result = await db.execute('SELECT * FROM apps');
    final mapped = result.map((row) => row.toColumnMap()).toList();
    return Response.ok(
      jsonEncode(mapped),
      headers: {'Content-Type': 'application/json'},
    );
  });

  router.post('/api/apps', (Request req) async {
    final payload = await req.readAsString();
    final data = jsonDecode(payload);

    await db.execute(
      Sql.named(
        'INSERT INTO apps (name, type, status) VALUES (@name, @type, @status)',
      ),
      parameters: {
        'name': data['name'],
        'type': data['type'],
        'status': data['status'],
      },
    );

    return Response.ok(
      '{"status": "ok"}',
      headers: {'Content-Type': 'application/json'},
    );
  });

  router.get('/api/roles', (Request req) async {
    final result = await db.execute('SELECT * FROM roles');
    final mapped = result.map((row) => row.toColumnMap()).toList();
    return Response.ok(
      jsonEncode(mapped),
      headers: {'Content-Type': 'application/json'},
    );
  });

  router.post('/api/roles', (Request req) async {
    final payload = await req.readAsString();
    final data = jsonDecode(payload);

    await db.execute(
      Sql.named(
        'INSERT INTO roles (name, code, status) VALUES (@name, @code, @status)',
      ),
      parameters: {
        'name': data['name'],
        'code': data['code'],
        'status': data['status'],
      },
    );

    return Response.ok(
      '{"status": "ok"}',
      headers: {'Content-Type': 'application/json'},
    );
  });

  router.get('/api/modules', (Request req) async {
    final result = await db.execute('SELECT * FROM modules');
    final mapped = result.map((row) => row.toColumnMap()).toList();
    return Response.ok(
      jsonEncode(mapped),
      headers: {'Content-Type': 'application/json'},
    );
  });

  router.post('/api/modules', (Request req) async {
    final payload = await req.readAsString();
    final data = jsonDecode(payload);

    await db.execute(
      Sql.named(
        'INSERT INTO modules (name, app_id, priority) VALUES (@name, @app_id, @priority)',
      ),
      parameters: {
        'name': data['name'],
        'app_id': data['app_id'],
        'priority': data['priority'],
      },
    );

    return Response.ok(
      '{"status": "ok"}',
      headers: {'Content-Type': 'application/json'},
    );
  });

  router.get('/api/features', (Request req) async {
    final result = await db.execute('SELECT * FROM features');
    final mapped = result.map((row) => row.toColumnMap()).toList();
    return Response.ok(
      jsonEncode(mapped),
      headers: {'Content-Type': 'application/json'},
    );
  });

  router.post('/api/features', (Request req) async {
    final payload = await req.readAsString();
    final data = jsonDecode(payload);

    await db.execute(
      Sql.named(
        'INSERT INTO features (requested_by, feature_name, intent, app_name, screens, apis, roles, status) VALUES (@requested_by, @feature_name, @intent, @app_name, @screens, @apis, @roles, @status)',
      ),
      parameters: {
        'requested_by': data['requested_by'],
        'feature_name': data['feature_name'],
        'intent': data['intent'],
        'app_name': data['app_name'],
        'screens': data['screens'],
        'apis': data['apis'],
        'roles': data['roles'],
        'status': data['status'],
      },
    );

    return Response.ok(
      '{"status": "ok"}',
      headers: {'Content-Type': 'application/json'},
    );
  });

  final ip = InternetAddress.anyIPv4;
  final handler = Pipeline()
      .addMiddleware(corsMiddleware())
      .addMiddleware(logRequests())
      .addHandler(router.call);

  final port = int.parse(Platform.environment['PORT'] ?? '8080');
  final server = await serve(handler, ip, port);
  print('Server listening on port ${server.port}');
}
