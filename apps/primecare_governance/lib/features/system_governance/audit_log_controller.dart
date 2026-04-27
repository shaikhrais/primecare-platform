import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/database/app_database.dart';

final auditLogsProvider = StreamProvider<List<AuditLog>>((ref) {
  final db = ref.watch(databaseProvider);
  return (db.select(db.auditLogs)
        ..orderBy([(t) => OrderingTerm(expression: t.timestamp, mode: OrderingMode.desc)]))
      .watch();
});
