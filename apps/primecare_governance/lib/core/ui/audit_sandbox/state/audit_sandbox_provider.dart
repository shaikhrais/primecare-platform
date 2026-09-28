import 'package:flutter_riverpod/legacy.dart';
import '../models/audit_sandbox_model.dart';

class AuditSandboxNotifier extends StateNotifier<AuditSandboxModel> {
  AuditSandboxNotifier() : super(const AuditSandboxModel(isLoading: true));

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

final audit_sandboxProvider = StateNotifierProvider<AuditSandboxNotifier, AuditSandboxModel>((ref) {
  return AuditSandboxNotifier()..loadData();
});
