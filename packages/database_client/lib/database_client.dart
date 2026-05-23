// Governance - Category: adapter | Purpose: Unified Database Client for PrimeCare Dart Services. Initializes the connection pool using environment variables.
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

    final dbUrl = Platform.environment['DATABASE_URL'];
    Endpoint endpoint;

    if (dbUrl != null && dbUrl.isNotEmpty) {
      final uri = Uri.parse(dbUrl);
      endpoint = Endpoint(
        host: uri.host,
        port: uri.port,
        database: uri.pathSegments.isNotEmpty ? uri.pathSegments.first : 'postgres',
        username: uri.userInfo.split(':').first,
        password: uri.userInfo.contains(':') ? uri.userInfo.split(':').last : null,
      );
    } else {
      endpoint = Endpoint(
        host: Platform.environment['DB_HOST'] ?? 'localhost',
        port: int.parse(Platform.environment['DB_PORT'] ?? '5432'),
        database: Platform.environment['DB_NAME'] ?? 'primecare',
        username: Platform.environment['DB_USER'] ?? 'postgres',
        password: Platform.environment['DB_PASSWORD'] ?? 'postgres',
      );
    }

    try {
      _connection = await Connection.open(
        endpoint,
        settings: const ConnectionSettings(sslMode: SslMode.require),
      );
      print('Connected to PostgreSQL at ${endpoint.host}:${endpoint.port}');
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

/// Stub class to satisfy legacy upgraded routes that declare a prisma instance.
class PrismaClient {}
