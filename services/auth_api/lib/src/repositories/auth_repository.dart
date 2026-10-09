import 'package:database_client/database_client.dart';

/// Existing auth queries; session policy remains in the HTTP controller.
class AuthRepository extends BasePlatformRepository {
  AuthRepository(super.database);

  Future<DatabaseResult> findUser(String email) => database.query(
      'SELECT id, roles, password_hash, status FROM users WHERE LOWER(email) = @email LIMIT 1',
      substitutionValues: {'email': email},
    );

  Future<DatabaseResult> createSession(String hash, dynamic id) => database.query(
      'INSERT INTO auth_sessions (token_hash, user_id, expires_at) '
      "VALUES (@hash, @id, NOW() + INTERVAL '12 hours')",
      substitutionValues: {'hash': hash, 'id': id},
    );

  Future<DatabaseResult> findSession(String hash) => database.query(
      'SELECT u.id, u.roles FROM auth_sessions s '
      'JOIN users u ON u.id = s.user_id '
      'WHERE s.token_hash = @hash AND s.expires_at > NOW() '
      "AND LOWER(u.status) = 'active' LIMIT 1",
      substitutionValues: {'hash': hash},
    );

  Future<DatabaseResult> deleteSession(String hash) => database.query(
      'DELETE FROM auth_sessions WHERE token_hash = @hash',
      substitutionValues: {'hash': hash},
    );
}
