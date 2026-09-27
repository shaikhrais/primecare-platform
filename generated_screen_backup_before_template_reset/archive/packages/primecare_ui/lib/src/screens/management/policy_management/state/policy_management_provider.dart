import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/policy_management_model.dart';

class PolicyManagementNotifier extends StateNotifier<PolicyManagementModel> {
  PolicyManagementNotifier() : super(const PolicyManagementModel(isLoading: true));

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

final policy_managementProvider = StateNotifierProvider<PolicyManagementNotifier, PolicyManagementModel>((ref) {
  return PolicyManagementNotifier()..loadData();
});
