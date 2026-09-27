import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/rpn_incident_review_model.dart';

class RpnIncidentReviewNotifier extends StateNotifier<RpnIncidentReviewModel> {
  RpnIncidentReviewNotifier() : super(const RpnIncidentReviewModel(isLoading: true));

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

final rpn_incident_reviewProvider = StateNotifierProvider<RpnIncidentReviewNotifier, RpnIncidentReviewModel>((ref) {
  return RpnIncidentReviewNotifier()..loadData();
});
