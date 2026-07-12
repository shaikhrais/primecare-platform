import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/clinical_director_incident_review_model.dart';

class ClinicalDirectorIncidentReviewNotifier extends StateNotifier<ClinicalDirectorIncidentReviewModel> {
  ClinicalDirectorIncidentReviewNotifier() : super(const ClinicalDirectorIncidentReviewModel(isLoading: true));

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

final clinical_director_incident_reviewProvider = StateNotifierProvider<ClinicalDirectorIncidentReviewNotifier, ClinicalDirectorIncidentReviewModel>((ref) {
  return ClinicalDirectorIncidentReviewNotifier()..loadData();
});
