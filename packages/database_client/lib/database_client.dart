import 'dart:io';
import 'package:postgres/postgres.dart';

/// Unified Database Client for PrimeCare Dart Services.
class PlatformDatabase {
  static final PlatformDatabase _instance = PlatformDatabase._internal();
  factory PlatformDatabase() => _instance;
  PlatformDatabase._internal();

  Connection? _connection;

  /// Initializes the connection pool using environment variables.
  Future<void> initialize() async {
    if (_connection != null) return;

    final host = Platform.environment['DB_HOST'] ?? 'localhost';
    final port = int.parse(Platform.environment['DB_PORT'] ?? '5432');
    final database = Platform.environment['DB_NAME'] ?? 'primecare';
    final username = Platform.environment['DB_USER'] ?? 'postgres';
    final password = Platform.environment['DB_PASSWORD'] ?? 'postgres';

    try {
      _connection = await Connection.open(
        Endpoint(
          host: host,
          port: port,
          database: database,
          username: username,
          password: password,
        ),
        settings: const ConnectionSettings(sslMode: SslMode.disable),
      );
      print('Connected to PostgreSQL at $host:$port');
    } catch (e) {
      print('Failed to connect to database: $e');
      rethrow;
    }
  }

  /// Executes a query and returns the results.
  Future<Result> query(String sql, {Map<String, dynamic>? substitutionValues}) async {
    if (_connection == null) await initialize();
    return await _connection!.execute(
      Sql.named(sql),
      parameters: substitutionValues ?? {},
    );
  }

  /// Closes the connection.
  Future<void> close() async {
    await _connection?.close();
    _connection = null;
  }
}
