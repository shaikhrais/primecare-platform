import 'package:flutter_riverpod/legacy.dart';
import '../models/admin_outstanding_balances_model.dart';

class AdminOutstandingBalancesNotifier extends StateNotifier<AdminOutstandingBalancesModel> {
  AdminOutstandingBalancesNotifier() : super(const AdminOutstandingBalancesModel(isLoading: true));

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

final admin_outstanding_balancesProvider = StateNotifierProvider<AdminOutstandingBalancesNotifier, AdminOutstandingBalancesModel>((ref) {
  return AdminOutstandingBalancesNotifier()..loadData();
});
