import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/database/database_provider.dart';
import 'governance_history_service.dart';

final governanceHistoryServiceProvider = Provider<GovernanceHistoryService>((ref) {
  final db = ref.watch(governanceDatabaseProvider);
  return GovernanceHistoryService(db);
});
