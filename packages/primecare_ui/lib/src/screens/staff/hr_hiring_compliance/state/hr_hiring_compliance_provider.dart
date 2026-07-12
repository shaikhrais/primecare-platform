import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/hr_hiring_compliance_model.dart';

class HrHiringComplianceNotifier extends StateNotifier<HrHiringComplianceModel> {
  HrHiringComplianceNotifier() : super(const HrHiringComplianceModel(isLoading: true));

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

final hr_hiring_complianceProvider = StateNotifierProvider<HrHiringComplianceNotifier, HrHiringComplianceModel>((ref) {
  return HrHiringComplianceNotifier()..loadData();
});
