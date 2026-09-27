// Governance - Category: adapter | Purpose: Core implementation file for the Governance Repository platform logic.
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
}
