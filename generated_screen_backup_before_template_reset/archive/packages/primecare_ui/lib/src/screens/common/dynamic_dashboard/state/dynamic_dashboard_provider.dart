import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/dynamic_dashboard_model.dart';

class DynamicDashboardNotifier extends StateNotifier<DynamicDashboardModel> {
  DynamicDashboardNotifier() : super(const DynamicDashboardModel(isLoading: true));

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

final dynamic_dashboardProvider = StateNotifierProvider<DynamicDashboardNotifier, DynamicDashboardModel>((ref) {
  return DynamicDashboardNotifier()..loadData();
});
