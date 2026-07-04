import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/training_dashboard_model.dart';

class TrainingDashboardNotifier extends StateNotifier<TrainingDashboardModel> {
  TrainingDashboardNotifier() : super(const TrainingDashboardModel(isLoading: true));

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

final training_dashboardProvider = StateNotifierProvider<TrainingDashboardNotifier, TrainingDashboardModel>((ref) {
  return TrainingDashboardNotifier()..loadData();
});
