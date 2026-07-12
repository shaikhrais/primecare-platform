import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/incident_review_model.dart';

class IncidentReviewNotifier extends StateNotifier<IncidentReviewModel> {
  IncidentReviewNotifier() : super(const IncidentReviewModel(isLoading: true));

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

final incident_reviewProvider = StateNotifierProvider<IncidentReviewNotifier, IncidentReviewModel>((ref) {
  return IncidentReviewNotifier()..loadData();
});
