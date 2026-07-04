import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/dynamic_screen_dashboard_model.dart';

class DynamicScreenDashboardNotifier extends StateNotifier<DynamicScreenDashboardModel> {
  DynamicScreenDashboardNotifier() : super(const DynamicScreenDashboardModel(isLoading: true));

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

final dynamic_screen_dashboardProvider = StateNotifierProvider<DynamicScreenDashboardNotifier, DynamicScreenDashboardModel>((ref) {
  return DynamicScreenDashboardNotifier()..loadData();
});
