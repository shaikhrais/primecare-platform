import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/risk_management_model.dart';

class RiskManagementNotifier extends StateNotifier<RiskManagementModel> {
  RiskManagementNotifier() : super(const RiskManagementModel(isLoading: true));

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

final risk_managementProvider = StateNotifierProvider<RiskManagementNotifier, RiskManagementModel>((ref) {
  return RiskManagementNotifier()..loadData();
});
