import 'package:flutter_riverpod/legacy.dart';
import '../models/training_director_reports_model.dart';

class TrainingDirectorReportsNotifier extends StateNotifier<TrainingDirectorReportsModel> {
  TrainingDirectorReportsNotifier() : super(const TrainingDirectorReportsModel(isLoading: true));

  Future<void> loadData() async {
    state = state.copyWith(isLoading: true);
    try {
      // TODO: Call API service
      state = state.copyWith(isLoading: false, data: const <String, dynamic>{});
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.toString());
    }
  }
}

final training_director_reportsProvider = StateNotifierProvider<TrainingDirectorReportsNotifier, TrainingDirectorReportsModel>((ref) {
  return TrainingDirectorReportsNotifier()..loadData();
});
