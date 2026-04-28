import 'dart:convert';
import 'package:shelf/shelf.dart';
import 'package:postgres/postgres.dart';
import '../database/database_controller.dart';

class GovernanceController {
  static final db = DatabaseController.connection;

  // Apps
  static Future<Response> getApps(Request request) async {
    final result = await db.execute('SELECT * FROM apps');
    final mapped = result.map((row) => row.toColumnMap()).toList();
    return Response.ok(
      jsonEncode(mapped),
      headers: {'Content-Type': 'application/json'},
    );
  }

  static Future<Response> createApp(Request request) async {
    final payload = await request.readAsString();
    final data = jsonDecode(payload);
    await db.execute(
      Sql.named('INSERT INTO apps (name, type, status) VALUES (@name, @type, @status)'),
      parameters: {
        'name': data['name'],
        'type': data['type'],
        'status': data['status'],
      },
    );
    return Response.ok('{"status": "ok"}', headers: {'Content-Type': 'application/json'});
  }

  // Roles
  static Future<Response> getRoles(Request request) async {
    final result = await db.execute('SELECT * FROM roles');
    final mapped = result.map((row) => row.toColumnMap()).toList();
    return Response.ok(jsonEncode(mapped), headers: {'Content-Type': 'application/json'});
  }

  static Future<Response> createRole(Request request) async {
    final payload = await request.readAsString();
    final data = jsonDecode(payload);
    await db.execute(
      Sql.named('INSERT INTO roles (name, code, status) VALUES (@name, @code, @status)'),
      parameters: {
        'name': data['name'],
        'code': data['code'],
        'status': data['status'],
      },
    );
    return Response.ok('{"status": "ok"}', headers: {'Content-Type': 'application/json'});
  }

  // Modules
  static Future<Response> getModules(Request request) async {
    final result = await db.execute('SELECT * FROM modules');
    final mapped = result.map((row) => row.toColumnMap()).toList();
    return Response.ok(jsonEncode(mapped), headers: {'Content-Type': 'application/json'});
  }

  static Future<Response> createModule(Request request) async {
    final payload = await request.readAsString();
    final data = jsonDecode(payload);
    await db.execute(
      Sql.named('INSERT INTO modules (name, app_id, priority) VALUES (@name, @app_id, @priority)'),
      parameters: {
        'name': data['name'],
        'app_id': data['app_id'],
        'priority': data['priority'],
      },
    );
    return Response.ok('{"status": "ok"}', headers: {'Content-Type': 'application/json'});
  }

  // Features
  static Future<Response> getFeatures(Request request) async {
    final result = await db.execute('SELECT * FROM features');
    final mapped = result.map((row) => row.toColumnMap()).toList();
    return Response.ok(jsonEncode(mapped), headers: {'Content-Type': 'application/json'});
  }

  static Future<Response> createFeature(Request request) async {
    final payload = await request.readAsString();
    final data = jsonDecode(payload);
    await db.execute(
      Sql.named(
          'INSERT INTO features (requested_by, feature_name, intent, app_name, screens, apis, roles, status) VALUES (@requested_by, @feature_name, @intent, @app_name, @screens, @apis, @roles, @status)'),
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
    return Response.ok('{"status": "ok"}', headers: {'Content-Type': 'application/json'});
  }

  // Screens
  static Future<Response> getScreens(Request request) async {
    final result = await db.execute('SELECT * FROM screens');
    final mapped = result.map((row) => row.toColumnMap()).toList();
    return Response.ok(jsonEncode(mapped), headers: {'Content-Type': 'application/json'});
  }

  static Future<Response> createScreen(Request request) async {
    final payload = await request.readAsString();
    final data = jsonDecode(payload);
    await db.execute(
      Sql.named('INSERT INTO screens (name) VALUES (@name)'),
      parameters: {'name': data['name']},
    );
    return Response.ok('{"status": "ok"}', headers: {'Content-Type': 'application/json'});
  }

  // Routes
  static Future<Response> getRoutes(Request request) async {
    final result = await db.execute('SELECT * FROM routes');
    final mapped = result.map((row) => row.toColumnMap()).toList();
    return Response.ok(jsonEncode(mapped), headers: {'Content-Type': 'application/json'});
  }

  static Future<Response> createRoute(Request request) async {
    final payload = await request.readAsString();
    final data = jsonDecode(payload);
    await db.execute(
      Sql.named('INSERT INTO routes (path) VALUES (@path)'),
      parameters: {'path': data['path']},
    );
    return Response.ok('{"status": "ok"}', headers: {'Content-Type': 'application/json'});
  }

  // APIs
  static Future<Response> getApis(Request request) async {
    final result = await db.execute('SELECT * FROM apis');
    final mapped = result.map((row) => row.toColumnMap()).toList();
    return Response.ok(jsonEncode(mapped), headers: {'Content-Type': 'application/json'});
  }

  static Future<Response> createApi(Request request) async {
    final payload = await request.readAsString();
    final data = jsonDecode(payload);
    await db.execute(
      Sql.named('INSERT INTO apis (endpoint) VALUES (@endpoint)'),
      parameters: {'endpoint': data['endpoint']},
    );
    return Response.ok('{"status": "ok"}', headers: {'Content-Type': 'application/json'});
  }

  // Permissions
  static Future<Response> getPermissions(Request request) async {
    final result = await db.execute('SELECT * FROM permissions');
    final mapped = result.map((row) => row.toColumnMap()).toList();
    return Response.ok(jsonEncode(mapped), headers: {'Content-Type': 'application/json'});
  }

  static Future<Response> createPermission(Request request) async {
    final payload = await request.readAsString();
    final data = jsonDecode(payload);
    await db.execute(
      Sql.named('INSERT INTO permissions (code) VALUES (@code)'),
      parameters: {'code': data['code']},
    );
    return Response.ok('{"status": "ok"}', headers: {'Content-Type': 'application/json'});
  }

  // Languages
  static Future<Response> getLanguages(Request request) async {
    final result = await db.execute('SELECT * FROM languages');
    final mapped = result.map((row) => row.toColumnMap()).toList();
    return Response.ok(jsonEncode(mapped), headers: {'Content-Type': 'application/json'});
  }

  static Future<Response> createLanguage(Request request) async {
    final payload = await request.readAsString();
    final data = jsonDecode(payload);
    await db.execute(
      Sql.named('INSERT INTO languages (name) VALUES (@name)'),
      parameters: {'name': data['name']},
    );
    return Response.ok('{"status": "ok"}', headers: {'Content-Type': 'application/json'});
  }

  // Statuses
  static Future<Response> getStatuses(Request request) async {
    final result = await db.execute('SELECT * FROM statuses');
    final mapped = result.map((row) => row.toColumnMap()).toList();
    return Response.ok(jsonEncode(mapped), headers: {'Content-Type': 'application/json'});
  }

  static Future<Response> createStatus(Request request) async {
    final payload = await request.readAsString();
    final data = jsonDecode(payload);
    await db.execute(
      Sql.named('INSERT INTO statuses (name) VALUES (@name)'),
      parameters: {'name': data['name']},
    );
    return Response.ok('{"status": "ok"}', headers: {'Content-Type': 'application/json'});
  }
}
