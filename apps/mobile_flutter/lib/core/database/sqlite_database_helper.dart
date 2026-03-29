import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite_common_ffi_web/sqflite_ffi_web.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class SqliteDatabaseHelper {
  static final SqliteDatabaseHelper instance = SqliteDatabaseHelper._init();
  static Database? _database;

  SqliteDatabaseHelper._init();

  Future<Database?> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('primecare_offline_queue.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    if (kIsWeb) {
      databaseFactory = databaseFactoryFfiWeb;
      return await databaseFactory.openDatabase(filePath, options: OpenDatabaseOptions(version: 1, onCreate: _createDB));
    } else {
      final dbPath = await getApplicationDocumentsDirectory();
      final path = join(dbPath.path, filePath);
      return await openDatabase(path, version: 1, onCreate: _createDB);
    }
  }

  Future _createDB(Database db, int version) async {
    const idType = 'TEXT PRIMARY KEY';
    const textType = 'TEXT NOT NULL';
    const floatType = 'REAL NOT NULL';

    // Abstract Payload Table
    await db.execute('''
      CREATE TABLE OfflineQueue (
        id $idType,
        httpMethod $textType,
        endpointUrl $textType,
        jsonPayload $textType,
        timestamp $floatType,
        retryCount INTEGER DEFAULT 0
      )
    ''');
    
    // Persistent Endpoint Cache
    await db.execute('''
      CREATE TABLE CacheStore (
        endpointUrl $idType,
        jsonResponse $textType,
        lastUpdated $floatType
      )
    ''');
  }

  Future<int> cacheEndpointData(String url, String json) async {
    final db = await instance.database;
    if (db == null) return 0;
    return await db.insert(
      'CacheStore',
      {
        'endpointUrl': url,
        'jsonResponse': json,
        'lastUpdated': DateTime.now().millisecondsSinceEpoch.toDouble(),
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<String?> getCachedEndpointData(String url) async {
    final db = await instance.database;
    if (db == null) return null;
    final results = await db.query('CacheStore', where: 'endpointUrl = ?', whereArgs: [url]);
    if (results.isNotEmpty) {
      return results.first['jsonResponse'] as String;
    }
    return null;
  }

  Future<int> insertPayload(Map<String, dynamic> row) async {
    final db = await instance.database;
    if (db == null) return 0; // PWA Bypass
    return await db.insert(
      'OfflineQueue',
      row,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Map<String, dynamic>>> readAllPendingPayloads() async {
    final db = await instance.database;
    if (db == null) return []; // PWA limits Array
    const orderBy = 'timestamp ASC';
    return await db.query('OfflineQueue', orderBy: orderBy);
  }

  Future<int> deletePayload(String id) async {
    final db = await instance.database;
    if (db == null) return 0; 
    return await db.delete('OfflineQueue', where: 'id = ?', whereArgs: [id]);
  }

  Future<int> incrementRetryCount(String id) async {
    final db = await instance.database;
    if (db == null) return 0;
    return await db.rawUpdate(
      '''
      UPDATE OfflineQueue 
      SET retryCount = retryCount + 1 
      WHERE id = ?
      ''',
      [id],
    );
  }

  Future close() async {
    final db = await instance.database;
    db?.close();
  }
}
