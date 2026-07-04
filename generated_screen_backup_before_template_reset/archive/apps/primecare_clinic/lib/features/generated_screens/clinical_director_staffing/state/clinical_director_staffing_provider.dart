import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/clinical_director_staffing_model.dart';

class ClinicalDirectorStaffingNotifier extends StateNotifier<ClinicalDirectorStaffingModel> {
  ClinicalDirectorStaffingNotifier() : super(const ClinicalDirectorStaffingModel(isLoading: true));

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

final clinical_director_staffingProvider = StateNotifierProvider<ClinicalDirectorStaffingNotifier, ClinicalDirectorStaffingModel>((ref) {
  return ClinicalDirectorStaffingNotifier()..loadData();
});
