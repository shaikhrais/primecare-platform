// Web database implementation using drift_web for Flutter Web builds
import 'package:drift/web.dart';
import 'package:drift/drift.dart';

/// Provides a [QueryExecutor] that works in the browser using IndexedDB.
/// The rest of the codebase can import `package:flutter_core/database/database.dart`
/// which conditionally exports this file for web platforms.
Future<QueryExecutor> open() async {
  // The database name used in IndexedDB.
  const dbName = 'primecare.db';
  // `WebDatabase` implements Drift's [QueryExecutor] for browsers.
  // No additional initialization is required.
  return WebDatabase(dbName);
}
