import 'dart:io';
import 'package:postgres/postgres.dart';

class DatabaseController {
  static late Connection _connection;

  static Connection get connection => _connection;

  static Future<void> initialize() async {
    final dbUrl = Platform.environment['DATABASE_URL'] ??
        'postgresql://postgres:password@localhost:5432/primecare';
    final uri = Uri.parse(dbUrl);

    final userInfo = uri.userInfo.split(':');
    final username = userInfo.isNotEmpty ? userInfo[0] : 'postgres';
    final password = userInfo.length > 1 ? userInfo[1] : 'password';

    _connection = await Connection.open(
      Endpoint(
        host: uri.host,
        port: uri.port,
        database: uri.pathSegments.isNotEmpty ? uri.pathSegments.first : 'primecare',
        username: username,
        password: password,
      ),
      settings: ConnectionSettings(sslMode: SslMode.disable),
    );

    await _runMigrations();
  }

  static Future<void> _runMigrations() async {
    await _connection.execute('''
      CREATE TABLE IF NOT EXISTS apps (
        id SERIAL PRIMARY KEY,
        name TEXT NOT NULL,
        type TEXT NOT NULL,
        status TEXT NOT NULL
      );
    ''');

    await _connection.execute('''
      CREATE TABLE IF NOT EXISTS roles (
        id SERIAL PRIMARY KEY,
        name TEXT NOT NULL,
        code TEXT NOT NULL,
        status TEXT NOT NULL
      );
    ''');

    await _connection.execute('''
      CREATE TABLE IF NOT EXISTS modules (
        id SERIAL PRIMARY KEY,
        name TEXT NOT NULL,
        app_id TEXT,
        priority TEXT NOT NULL
      );
    ''');

    await _connection.execute('''
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

    await _connection.execute('''
      CREATE TABLE IF NOT EXISTS screens (
        id SERIAL PRIMARY KEY,
        name TEXT NOT NULL
      );
    ''');

    await _connection.execute('''
      CREATE TABLE IF NOT EXISTS routes (
        id SERIAL PRIMARY KEY,
        path TEXT NOT NULL
      );
    ''');

    await _connection.execute('''
      CREATE TABLE IF NOT EXISTS apis (
        id SERIAL PRIMARY KEY,
        endpoint TEXT NOT NULL
      );
    ''');

    await _connection.execute('''
      CREATE TABLE IF NOT EXISTS permissions (
        id SERIAL PRIMARY KEY,
        code TEXT NOT NULL
      );
    ''');

    await _connection.execute('''
      CREATE TABLE IF NOT EXISTS languages (
        id SERIAL PRIMARY KEY,
        name TEXT NOT NULL
      );
    ''');

    await _connection.execute('''
      CREATE TABLE IF NOT EXISTS statuses (
        id SERIAL PRIMARY KEY,
        name TEXT NOT NULL
      );
    ''');
  }
}
