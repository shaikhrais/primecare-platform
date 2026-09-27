import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/training_coordinator_reports_model.dart';

class TrainingCoordinatorReportsNotifier extends StateNotifier<TrainingCoordinatorReportsModel> {
  TrainingCoordinatorReportsNotifier() : super(const TrainingCoordinatorReportsModel(isLoading: true));

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

final training_coordinator_reportsProvider = StateNotifierProvider<TrainingCoordinatorReportsNotifier, TrainingCoordinatorReportsModel>((ref) {
  return TrainingCoordinatorReportsNotifier()..loadData();
});
