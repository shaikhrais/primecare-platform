// Native database implementation using Drift's pure‑Dart SQLite driver (no sqflite)
import 'dart:io';
import 'package:drift/ffi.dart' as ffi;
import 'package:drift/drift.dart';

class NativeDatabase {
  static Future<QueryExecutor> open() async {
    final dbFile = File('primecare.db');
    // Ensure the directory exists.
    await dbFile.parent.create(recursive: true);
    return ffi.NativeDatabase(dbFile);
  }
}
