import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/admin_reconciliation_model.dart';

class AdminReconciliationNotifier extends StateNotifier<AdminReconciliationModel> {
  AdminReconciliationNotifier() : super(const AdminReconciliationModel(isLoading: true));

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

final admin_reconciliationProvider = StateNotifierProvider<AdminReconciliationNotifier, AdminReconciliationModel>((ref) {
  return AdminReconciliationNotifier()..loadData();
});
