import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/rn_care_plan_review_model.dart';

class RnCarePlanReviewNotifier extends StateNotifier<RnCarePlanReviewModel> {
  RnCarePlanReviewNotifier() : super(const RnCarePlanReviewModel(isLoading: true));

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

final rn_care_plan_reviewProvider = StateNotifierProvider<RnCarePlanReviewNotifier, RnCarePlanReviewModel>((ref) {
  return RnCarePlanReviewNotifier()..loadData();
});
