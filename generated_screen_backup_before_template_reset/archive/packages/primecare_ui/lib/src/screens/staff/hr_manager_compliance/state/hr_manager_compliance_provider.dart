import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/hr_manager_compliance_model.dart';

class HrManagerComplianceNotifier extends StateNotifier<HrManagerComplianceModel> {
  HrManagerComplianceNotifier() : super(const HrManagerComplianceModel(isLoading: true));

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

final hr_manager_complianceProvider = StateNotifierProvider<HrManagerComplianceNotifier, HrManagerComplianceModel>((ref) {
  return HrManagerComplianceNotifier()..loadData();
});
