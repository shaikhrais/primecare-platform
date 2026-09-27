// Native database implementation using Drift's pure‑Dart SQLite driver (no sqflite)
import 'dart:io';
import 'package:drift/native.dart' as drift_native;
import 'package:drift/drift.dart';

class NativeDatabase {
  static Future<QueryExecutor> open() async {
    final dbFile = File('primecare.db');
    // Ensure the directory exists.
    await dbFile.parent.create(recursive: true);
    return drift_native.NativeDatabase(dbFile);
  }
}
