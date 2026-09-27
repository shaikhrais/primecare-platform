import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/rn_incident_review_model.dart';

class RnIncidentReviewNotifier extends StateNotifier<RnIncidentReviewModel> {
  RnIncidentReviewNotifier() : super(const RnIncidentReviewModel(isLoading: true));

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

final rn_incident_reviewProvider = StateNotifierProvider<RnIncidentReviewNotifier, RnIncidentReviewModel>((ref) {
  return RnIncidentReviewNotifier()..loadData();
});
