import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/rmt_exercise_plan_model.dart';

class RmtExercisePlanNotifier extends StateNotifier<RmtExercisePlanModel> {
  RmtExercisePlanNotifier() : super(const RmtExercisePlanModel(isLoading: true));

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

final rmt_exercise_planProvider = StateNotifierProvider<RmtExercisePlanNotifier, RmtExercisePlanModel>((ref) {
  return RmtExercisePlanNotifier()..loadData();
});
