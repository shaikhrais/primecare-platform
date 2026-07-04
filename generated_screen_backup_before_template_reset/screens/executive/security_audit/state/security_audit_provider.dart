import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/security_audit_model.dart';

class SecurityAuditNotifier extends StateNotifier<SecurityAuditModel> {
  SecurityAuditNotifier() : super(const SecurityAuditModel(isLoading: true));

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

final security_auditProvider = StateNotifierProvider<SecurityAuditNotifier, SecurityAuditModel>((ref) {
  return SecurityAuditNotifier()..loadData();
});
