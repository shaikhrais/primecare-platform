import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/clinical_quality_model.dart';

class ClinicalQualityNotifier extends StateNotifier<ClinicalQualityModel> {
  ClinicalQualityNotifier() : super(const ClinicalQualityModel(isLoading: true));

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

final clinical_qualityProvider = StateNotifierProvider<ClinicalQualityNotifier, ClinicalQualityModel>((ref) {
  return ClinicalQualityNotifier()..loadData();
});
