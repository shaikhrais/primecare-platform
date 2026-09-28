import 'package:flutter_riverpod/legacy.dart';
import '../models/training_reports_model.dart';

class TrainingReportsNotifier extends StateNotifier<TrainingReportsModel> {
  TrainingReportsNotifier() : super(const TrainingReportsModel(isLoading: true));

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

final training_reportsProvider = StateNotifierProvider<TrainingReportsNotifier, TrainingReportsModel>((ref) {
  return TrainingReportsNotifier()..loadData();
});
