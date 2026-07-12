import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/physiotherapist_exercise_plan_model.dart';

class PhysiotherapistExercisePlanNotifier extends StateNotifier<PhysiotherapistExercisePlanModel> {
  PhysiotherapistExercisePlanNotifier() : super(const PhysiotherapistExercisePlanModel(isLoading: true));

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

final physiotherapist_exercise_planProvider = StateNotifierProvider<PhysiotherapistExercisePlanNotifier, PhysiotherapistExercisePlanModel>((ref) {
  return PhysiotherapistExercisePlanNotifier()..loadData();
});
