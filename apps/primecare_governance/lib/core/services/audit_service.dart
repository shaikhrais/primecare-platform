import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../database/app_database.dart';
import 'package:drift/drift.dart';

class AuditService {
  final AppDatabase _db;

  AuditService(this._db);

  Future<void> logAction(String action, String details) async {
    await _db
        .into(_db.auditLogs)
        .insert(
          AuditLogsCompanion.insert(
            action: action,
            details: details,
            timestamp: Value(DateTime.now()),
            isSynced: const Value(false),
          ),
        );

    // In a real app, attempt to sync here if connectivity is available
    _syncWithBackend();
  }

  Future<List<AuditLog>> getLocalLogs() {
    return _db.select(_db.auditLogs).get();
  }

  Future<void> _syncWithBackend() async {
    // Logic to push local logs to the microservices backend
    // and mark them as isSynced = true in Drift
  }
}

final auditServiceProvider = Provider((ref) {
  final db = ref.watch(databaseProvider);
  return AuditService(db);
});
