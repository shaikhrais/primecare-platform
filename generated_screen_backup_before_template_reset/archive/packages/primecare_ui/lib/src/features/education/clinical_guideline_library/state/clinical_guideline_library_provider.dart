import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/clinical_guideline_library_model.dart';

class ClinicalGuidelineLibraryNotifier extends StateNotifier<ClinicalGuidelineLibraryModel> {
  ClinicalGuidelineLibraryNotifier() : super(const ClinicalGuidelineLibraryModel(isLoading: true));

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

final clinical_guideline_libraryProvider = StateNotifierProvider<ClinicalGuidelineLibraryNotifier, ClinicalGuidelineLibraryModel>((ref) {
  return ClinicalGuidelineLibraryNotifier()..loadData();
});
