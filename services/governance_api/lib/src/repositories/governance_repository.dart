// Governance - Category: adapter | Purpose: Core implementation file for the Governance Repository platform logic.
import 'package:postgres/postgres.dart';
import '../core/base_repository.dart';

class GovernanceRepository extends BaseRepository {
  GovernanceRepository(super.connection);

  Future<List<Map<String, dynamic>>> getApps() async {
    final result = await connection.execute('SELECT * FROM apps');
    return mapResult(result);
  }

  Future<List<Map<String, dynamic>>> getRoles() async {
    final result = await connection.execute('SELECT * FROM roles');
    return mapResult(result);
  }

  Future<List<Map<String, dynamic>>> getFeatures() async {
    final result = await connection.execute('SELECT * FROM features');
    return mapResult(result);
  }

  Future<List<Map<String, dynamic>>> getApis() async {
    final result = await connection.execute('SELECT * FROM apis');
    return mapResult(result);
  }

  Future<List<Map<String, dynamic>>> getScreens() async {
    final result = await connection.execute('SELECT * FROM screens');
    return mapResult(result);
  }

  Future<void> remediate4KStandard() async {
    await connection.execute(
      'UPDATE apis SET design_size_width = 3840, design_size_height = 2160 WHERE design_size_width IS NULL OR design_size_width != 3840'
    );
  }

  Future<void> logEvent({
    required String type,
    required String message,
    required String level,
    Map<String, dynamic> metadata = const {},
  }) async {
    await connection.execute(
      'INSERT INTO governance_events (type, message, level, metadata, created_at) VALUES (@type, @message, @level, @metadata, NOW())',
      parameters: {
        'type': type,
        'message': message,
        'level': level,
        'metadata': metadata,
      },
    );
  }

  Future<List<Map<String, dynamic>>> getEvents({int limit = 50}) async {
    final result = await connection.execute(
      'SELECT * FROM governance_events ORDER BY created_at DESC LIMIT @limit',
      parameters: {'limit': limit},
    );
    return mapResult(result);
  }

  Future<void> createApp(dynamic data) async {
    await connection.execute(
      Sql.named('INSERT INTO apps (name, type, status) VALUES (@name, @type, @status)'),
      parameters: {
        'name': data['name'],
        'type': data['type'],
        'status': data['status'],
      },
    );
  }

  Future<void> createRole(dynamic data) async {
    await connection.execute(
      Sql.named('INSERT INTO roles (name, code, status) VALUES (@name, @code, @status)'),
      parameters: {
        'name': data['name'],
        'code': data['code'],
        'status': data['status'],
      },
    );
  }

  Future<List<Map<String, dynamic>>> getModules() async {
    final result = await connection.execute('SELECT * FROM modules');
    return mapResult(result);
  }

  Future<void> createModule(dynamic data) async {
    await connection.execute(
      Sql.named('INSERT INTO modules (name, app_id, priority) VALUES (@name, @app_id, @priority)'),
      parameters: {
        'name': data['name'],
        'app_id': data['app_id'],
        'priority': data['priority'],
      },
    );
  }

  Future<void> createFeature(dynamic data) async {
    await connection.execute(
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
  }

  Future<void> createScreen(dynamic data) async {
    await connection.execute(
      Sql.named('INSERT INTO screens (name) VALUES (@name)'),
      parameters: {'name': data['name']},
    );
  }

  Future<List<Map<String, dynamic>>> getRoutes() async {
    final result = await connection.execute('SELECT * FROM routes');
    return mapResult(result);
  }

  Future<void> createRoute(dynamic data) async {
    await connection.execute(
      Sql.named('INSERT INTO routes (path) VALUES (@path)'),
      parameters: {'path': data['path']},
    );
  }

  Future<void> createApi(dynamic data) async {
    await connection.execute(
      Sql.named('INSERT INTO apis (endpoint) VALUES (@endpoint)'),
      parameters: {'endpoint': data['endpoint']},
    );
  }

  Future<List<Map<String, dynamic>>> getPermissions() async {
    final result = await connection.execute('SELECT * FROM permissions');
    return mapResult(result);
  }

  Future<void> createPermission(dynamic data) async {
    await connection.execute(
      Sql.named('INSERT INTO permissions (code) VALUES (@code)'),
      parameters: {'code': data['code']},
    );
  }

  Future<List<Map<String, dynamic>>> getLanguages() async {
    final result = await connection.execute('SELECT * FROM languages');
    return mapResult(result);
  }

  Future<void> createLanguage(dynamic data) async {
    await connection.execute(
      Sql.named('INSERT INTO languages (name) VALUES (@name)'),
      parameters: {'name': data['name']},
    );
  }

  Future<List<Map<String, dynamic>>> getStatuses() async {
    final result = await connection.execute('SELECT * FROM statuses');
    return mapResult(result);
  }

  Future<void> createStatus(dynamic data) async {
    await connection.execute(
      Sql.named('INSERT INTO statuses (name) VALUES (@name)'),
      parameters: {'name': data['name']},
    );
  }

}
