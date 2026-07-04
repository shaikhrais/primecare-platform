import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/training_hub_dashboard_model.dart';

class TrainingHubDashboardNotifier extends StateNotifier<TrainingHubDashboardModel> {
  TrainingHubDashboardNotifier() : super(const TrainingHubDashboardModel(isLoading: true));

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

final training_hub_dashboardProvider = StateNotifierProvider<TrainingHubDashboardNotifier, TrainingHubDashboardModel>((ref) {
  return TrainingHubDashboardNotifier()..loadData();
});
