import 'package:flutter_riverpod/legacy.dart';
import '../models/cto_audit_logs_model.dart';

class CtoAuditLogsNotifier extends StateNotifier<CtoAuditLogsModel> {
  CtoAuditLogsNotifier() : super(const CtoAuditLogsModel(isLoading: true));

  Future<void> loadData() async {
    state = state.copyWith(isLoading: true);
    try {
      // TODO: Call API service
      state = state.copyWith(isLoading: false, data: const <String, dynamic>{});
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.toString());
    }
  }
}

final cto_audit_logsProvider = StateNotifierProvider<CtoAuditLogsNotifier, CtoAuditLogsModel>((ref) {
  return CtoAuditLogsNotifier()..loadData();
});
