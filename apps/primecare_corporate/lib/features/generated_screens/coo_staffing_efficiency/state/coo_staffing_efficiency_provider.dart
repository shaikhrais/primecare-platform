import 'package:flutter_riverpod/legacy.dart';
import '../models/coo_staffing_efficiency_model.dart';

class CooStaffingEfficiencyNotifier extends StateNotifier<CooStaffingEfficiencyModel> {
  CooStaffingEfficiencyNotifier() : super(const CooStaffingEfficiencyModel(isLoading: true));

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

final coo_staffing_efficiencyProvider = StateNotifierProvider<CooStaffingEfficiencyNotifier, CooStaffingEfficiencyModel>((ref) {
  return CooStaffingEfficiencyNotifier()..loadData();
});
