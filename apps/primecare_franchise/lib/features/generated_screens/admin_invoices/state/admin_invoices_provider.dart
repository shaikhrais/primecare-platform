import 'package:flutter_riverpod/legacy.dart';
import '../models/admin_invoices_model.dart';

class AdminInvoicesNotifier extends StateNotifier<AdminInvoicesModel> {
  AdminInvoicesNotifier() : super(const AdminInvoicesModel(isLoading: true));

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

final admin_invoicesProvider = StateNotifierProvider<AdminInvoicesNotifier, AdminInvoicesModel>((ref) {
  return AdminInvoicesNotifier()..loadData();
});
