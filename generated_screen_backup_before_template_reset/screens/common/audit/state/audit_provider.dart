import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/audit_model.dart';

class AuditNotifier extends StateNotifier<AuditModel> {
  AuditNotifier() : super(const AuditModel(isLoading: true));

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

final auditProvider = StateNotifierProvider<AuditNotifier, AuditModel>((ref) {
  return AuditNotifier()..loadData();
});
