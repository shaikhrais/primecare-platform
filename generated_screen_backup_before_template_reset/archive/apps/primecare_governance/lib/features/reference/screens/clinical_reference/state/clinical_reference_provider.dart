import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/clinical_reference_model.dart';

class ClinicalReferenceNotifier extends StateNotifier<ClinicalReferenceModel> {
  ClinicalReferenceNotifier() : super(const ClinicalReferenceModel(isLoading: true));

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

final clinical_referenceProvider = StateNotifierProvider<ClinicalReferenceNotifier, ClinicalReferenceModel>((ref) {
  return ClinicalReferenceNotifier()..loadData();
});
