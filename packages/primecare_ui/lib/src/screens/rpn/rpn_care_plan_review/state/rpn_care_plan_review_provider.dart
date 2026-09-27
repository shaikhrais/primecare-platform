import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/rpn_care_plan_review_model.dart';

class RpnCarePlanReviewNotifier extends StateNotifier<RpnCarePlanReviewModel> {
  RpnCarePlanReviewNotifier() : super(const RpnCarePlanReviewModel(isLoading: true));

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

final rpn_care_plan_reviewProvider = StateNotifierProvider<RpnCarePlanReviewNotifier, RpnCarePlanReviewModel>((ref) {
  return RpnCarePlanReviewNotifier()..loadData();
});
