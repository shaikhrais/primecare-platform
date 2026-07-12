import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/clinical_director_staff_quality_model.dart';

class ClinicalDirectorStaffQualityNotifier extends StateNotifier<ClinicalDirectorStaffQualityModel> {
  ClinicalDirectorStaffQualityNotifier() : super(const ClinicalDirectorStaffQualityModel(isLoading: true));

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

final clinical_director_staff_qualityProvider = StateNotifierProvider<ClinicalDirectorStaffQualityNotifier, ClinicalDirectorStaffQualityModel>((ref) {
  return ClinicalDirectorStaffQualityNotifier()..loadData();
});
