import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class SqliteDatabaseHelper {
  static final SqliteDatabaseHelper instance = SqliteDatabaseHelper._init();
  static Database? _database;

  SqliteDatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('primecare_offline_queue.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getApplicationDocumentsDirectory();
    final path = join(dbPath.path, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    const idType = 'TEXT PRIMARY KEY';
    const textType = 'TEXT NOT NULL';
    const floatType = 'REAL NOT NULL';

    // Abstract Payload Table
    await db.execute('''
      CREATE TABLE OfflineQueue (
        id \$idType,
        httpMethod \$textType,
        endpointUrl \$textType,
        jsonPayload \$textType,
        timestamp \$floatType,
        retryCount INTEGER DEFAULT 0
      )
    ''');
  }

  Future<int> insertPayload(Map<String, dynamic> row) async {
    final db = await instance.database;
    return await db.insert(
      'OfflineQueue',
      row,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Map<String, dynamic>>> readAllPendingPayloads() async {
    final db = await instance.database;
    const orderBy = 'timestamp ASC';
    return await db.query('OfflineQueue', orderBy: orderBy);
  }

  Future<int> deletePayload(String id) async {
    final db = await instance.database;
    return await db.delete('OfflineQueue', where: 'id = ?', whereArgs: [id]);
  }

  Future<int> incrementRetryCount(String id) async {
    final db = await instance.database;
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
    db.close();
  }
}
