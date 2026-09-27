import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/screen_audit_model.dart';

class ScreenAuditNotifier extends StateNotifier<ScreenAuditModel> {
  ScreenAuditNotifier() : super(const ScreenAuditModel(isLoading: true));

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

final screen_auditProvider = StateNotifierProvider<ScreenAuditNotifier, ScreenAuditModel>((ref) {
  return ScreenAuditNotifier()..loadData();
});
