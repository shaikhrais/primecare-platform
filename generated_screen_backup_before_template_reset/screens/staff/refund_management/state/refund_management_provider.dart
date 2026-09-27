import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/refund_management_model.dart';

class RefundManagementNotifier extends StateNotifier<RefundManagementModel> {
  RefundManagementNotifier() : super(const RefundManagementModel(isLoading: true));

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

final refund_managementProvider = StateNotifierProvider<RefundManagementNotifier, RefundManagementModel>((ref) {
  return RefundManagementNotifier()..loadData();
});
