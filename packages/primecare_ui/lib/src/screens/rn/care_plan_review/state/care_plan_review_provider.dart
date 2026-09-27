import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/care_plan_review_model.dart';

class CarePlanReviewNotifier extends StateNotifier<CarePlanReviewModel> {
  CarePlanReviewNotifier() : super(const CarePlanReviewModel(isLoading: true));

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

final care_plan_reviewProvider = StateNotifierProvider<CarePlanReviewNotifier, CarePlanReviewModel>((ref) {
  return CarePlanReviewNotifier()..loadData();
});
