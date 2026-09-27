import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/training_director_dashboard_model.dart';

class TrainingDirectorDashboardNotifier extends StateNotifier<TrainingDirectorDashboardModel> {
  TrainingDirectorDashboardNotifier() : super(const TrainingDirectorDashboardModel(isLoading: true));

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

final training_director_dashboardProvider = StateNotifierProvider<TrainingDirectorDashboardNotifier, TrainingDirectorDashboardModel>((ref) {
  return TrainingDirectorDashboardNotifier()..loadData();
});
