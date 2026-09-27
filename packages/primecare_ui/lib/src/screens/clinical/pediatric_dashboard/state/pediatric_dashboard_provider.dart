import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/pediatric_dashboard_model.dart';

class PediatricDashboardNotifier extends StateNotifier<PediatricDashboardModel> {
  PediatricDashboardNotifier() : super(const PediatricDashboardModel(isLoading: true));

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

final pediatric_dashboardProvider = StateNotifierProvider<PediatricDashboardNotifier, PediatricDashboardModel>((ref) {
  return PediatricDashboardNotifier()..loadData();
});
