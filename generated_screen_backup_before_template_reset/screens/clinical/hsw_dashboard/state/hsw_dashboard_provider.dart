import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/hsw_dashboard_model.dart';

class HswDashboardNotifier extends StateNotifier<HswDashboardModel> {
  HswDashboardNotifier() : super(const HswDashboardModel(isLoading: true));

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

final hsw_dashboardProvider = StateNotifierProvider<HswDashboardNotifier, HswDashboardModel>((ref) {
  return HswDashboardNotifier()..loadData();
});
