import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/audit_log_model.dart';

class AuditLogNotifier extends StateNotifier<AuditLogModel> {
  AuditLogNotifier() : super(const AuditLogModel(isLoading: true));

  Future<void> loadData() async {
    state = state.copyWith(isLoading: true);
    try {
      // TODO: Call API service
      state = state.copyWith(isLoading: false, data: const {});
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.toString());
    }
  }
}

final audit_logProvider = StateNotifierProvider<AuditLogNotifier, AuditLogModel>((ref) {
  return AuditLogNotifier()..loadData();
});
