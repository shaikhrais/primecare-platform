import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/hr_director_training_model.dart';

class HrDirectorTrainingNotifier extends StateNotifier<HrDirectorTrainingModel> {
  HrDirectorTrainingNotifier() : super(const HrDirectorTrainingModel(isLoading: true));

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

final hr_director_trainingProvider = StateNotifierProvider<HrDirectorTrainingNotifier, HrDirectorTrainingModel>((ref) {
  return HrDirectorTrainingNotifier()..loadData();
});
