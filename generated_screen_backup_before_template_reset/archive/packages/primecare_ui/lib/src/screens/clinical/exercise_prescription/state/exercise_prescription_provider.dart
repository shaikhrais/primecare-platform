import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/exercise_prescription_model.dart';

class ExercisePrescriptionNotifier extends StateNotifier<ExercisePrescriptionModel> {
  ExercisePrescriptionNotifier() : super(const ExercisePrescriptionModel(isLoading: true));

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

final exercise_prescriptionProvider = StateNotifierProvider<ExercisePrescriptionNotifier, ExercisePrescriptionModel>((ref) {
  return ExercisePrescriptionNotifier()..loadData();
});
