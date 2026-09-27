import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/training_coordinator_dashboard_model.dart';

class TrainingCoordinatorDashboardNotifier extends StateNotifier<TrainingCoordinatorDashboardModel> {
  TrainingCoordinatorDashboardNotifier() : super(const TrainingCoordinatorDashboardModel(isLoading: true));

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

final training_coordinator_dashboardProvider = StateNotifierProvider<TrainingCoordinatorDashboardNotifier, TrainingCoordinatorDashboardModel>((ref) {
  return TrainingCoordinatorDashboardNotifier()..loadData();
});
