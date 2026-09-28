import 'package:flutter_riverpod/legacy.dart';
import '../models/admin_payments_model.dart';

class AdminPaymentsNotifier extends StateNotifier<AdminPaymentsModel> {
  AdminPaymentsNotifier() : super(const AdminPaymentsModel(isLoading: true));

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

final admin_paymentsProvider = StateNotifierProvider<AdminPaymentsNotifier, AdminPaymentsModel>((ref) {
  return AdminPaymentsNotifier()..loadData();
});
