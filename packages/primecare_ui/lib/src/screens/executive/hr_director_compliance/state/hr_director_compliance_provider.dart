import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/hr_director_compliance_model.dart';

class HrDirectorComplianceNotifier extends StateNotifier<HrDirectorComplianceModel> {
  HrDirectorComplianceNotifier() : super(const HrDirectorComplianceModel(isLoading: true));

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

final hr_director_complianceProvider = StateNotifierProvider<HrDirectorComplianceNotifier, HrDirectorComplianceModel>((ref) {
  return HrDirectorComplianceNotifier()..loadData();
});
