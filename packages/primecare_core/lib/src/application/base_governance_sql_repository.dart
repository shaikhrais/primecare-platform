// ignore_for_file: avoid_dynamic_calls
// Retain the legacy dynamic governance payload contract.
abstract class BaseGovernanceSqlRepository<R> {
  Future<R> executeSql(
    String sql, {
    bool named = false,
    Map<String, dynamic>? parameters,
  });
  List<Map<String, dynamic>> mapResult(R result);

  Future<List<Map<String, dynamic>>> getApps() async {
    final result = await executeSql('SELECT * FROM apps');
    return mapResult(result);
  }

  Future<List<Map<String, dynamic>>> getRoles() async {
    final result = await executeSql('SELECT * FROM roles');
    return mapResult(result);
  }

  Future<List<Map<String, dynamic>>> getFeatures() async {
    final result = await executeSql('SELECT * FROM features');
    return mapResult(result);
  }

  Future<List<Map<String, dynamic>>> getApis() async {
    final result = await executeSql('SELECT * FROM apis');
    return mapResult(result);
  }

  Future<List<Map<String, dynamic>>> getScreens() async {
    final result = await executeSql('SELECT * FROM screens');
    return mapResult(result);
  }

  Future<void> remediate4KStandard() async {
    await executeSql(
      'UPDATE apis SET design_size_width = 3840, design_size_height = 2160 WHERE design_size_width IS NULL OR design_size_width != 3840',
    );
  }

  Future<void> logEvent({
    required String type,
    required String message,
    required String level,
    Map<String, dynamic> metadata = const {},
  }) async {
    await executeSql(
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
    final result = await executeSql(
      'SELECT * FROM governance_events ORDER BY created_at DESC LIMIT @limit',
      parameters: {'limit': limit},
    );
    return mapResult(result);
  }

  Future<void> createApp(dynamic data) async {
    await executeSql(
      'INSERT INTO apps (name, type, status) VALUES (@name, @type, @status)',
      named: true,
      parameters: {
        'name': data['name'],
        'type': data['type'],
        'status': data['status'],
      },
    );
  }

  Future<void> createRole(dynamic data) async {
    await executeSql(
      'INSERT INTO roles (name, code, status) VALUES (@name, @code, @status)',
      named: true,
      parameters: {
        'name': data['name'],
        'code': data['code'],
        'status': data['status'],
      },
    );
  }

  Future<List<Map<String, dynamic>>> getModules() async {
    final result = await executeSql('SELECT * FROM modules');
    return mapResult(result);
  }

  Future<void> createModule(dynamic data) async {
    await executeSql(
      'INSERT INTO modules (name, app_id, priority) VALUES (@name, @app_id, @priority)',
      named: true,
      parameters: {
        'name': data['name'],
        'app_id': data['app_id'],
        'priority': data['priority'],
      },
    );
  }

  Future<void> createFeature(dynamic data) async {
    await executeSql(
      'INSERT INTO features (requested_by, feature_name, intent, app_name, screens, apis, roles, status) VALUES (@requested_by, @feature_name, @intent, @app_name, @screens, @apis, @roles, @status)',
      named: true,
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
    await executeSql(
      'INSERT INTO screens (name) VALUES (@name)',
      named: true,
      parameters: {'name': data['name']},
    );
  }

  Future<List<Map<String, dynamic>>> getRoutes() async {
    final result = await executeSql('SELECT * FROM routes');
    return mapResult(result);
  }

  Future<void> createRoute(dynamic data) async {
    await executeSql(
      'INSERT INTO routes (path) VALUES (@path)',
      named: true,
      parameters: {'path': data['path']},
    );
  }

  Future<void> createApi(dynamic data) async {
    await executeSql(
      'INSERT INTO apis (endpoint) VALUES (@endpoint)',
      named: true,
      parameters: {'endpoint': data['endpoint']},
    );
  }

  Future<List<Map<String, dynamic>>> getPermissions() async {
    final result = await executeSql('SELECT * FROM permissions');
    return mapResult(result);
  }

  Future<void> createPermission(dynamic data) async {
    await executeSql(
      'INSERT INTO permissions (code) VALUES (@code)',
      named: true,
      parameters: {'code': data['code']},
    );
  }

  Future<List<Map<String, dynamic>>> getLanguages() async {
    final result = await executeSql('SELECT * FROM languages');
    return mapResult(result);
  }

  Future<void> createLanguage(dynamic data) async {
    await executeSql(
      'INSERT INTO languages (name) VALUES (@name)',
      named: true,
      parameters: {'name': data['name']},
    );
  }

  Future<List<Map<String, dynamic>>> getStatuses() async {
    final result = await executeSql('SELECT * FROM statuses');
    return mapResult(result);
  }

  Future<void> createStatus(dynamic data) async {
    await executeSql(
      'INSERT INTO statuses (name) VALUES (@name)',
      named: true,
      parameters: {'name': data['name']},
    );
  }
}
