import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final localDbProvider = Provider<LocalDbService>((ref) => LocalDbService());

class LocalDbService {
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  Future<Database> _initDB() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'primecare_offline_sync.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE EVVPendingTasks(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            visitId TEXT NOT NULL,
            payload TEXT NOT NULL,
            timestamp TEXT NOT NULL,
            endpoint TEXT NOT NULL,
            status TEXT DEFAULT 'pending'
          )
        ''');
      },
    );
  }

  Future<int> insertPendingTask(
    String visitId,
    String endpoint,
    Map<String, dynamic> payload,
  ) async {
    final db = await database;
    return await db.insert('EVVPendingTasks', {
      'visitId': visitId,
      'payload': jsonEncode(payload),
      'endpoint': endpoint,
      'timestamp': DateTime.now().toIso8601String(),
    });
  }

  Future<List<Map<String, dynamic>>> fetchPendingTasks() async {
    final db = await database;
    return await db.query(
      'EVVPendingTasks',
      where: 'status = ?',
      whereArgs: ['pending'],
    );
  }

  Future<int> deletePendingTask(int id) async {
    final db = await database;
    return await db.delete('EVVPendingTasks', where: 'id = ?', whereArgs: [id]);
  }
}
