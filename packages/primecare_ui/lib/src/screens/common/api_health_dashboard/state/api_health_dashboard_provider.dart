import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/api_health_dashboard_model.dart';

class ApiHealthDashboardNotifier extends StateNotifier<ApiHealthDashboardModel> {
  ApiHealthDashboardNotifier() : super(const ApiHealthDashboardModel(isLoading: true));

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

final api_health_dashboardProvider = StateNotifierProvider<ApiHealthDashboardNotifier, ApiHealthDashboardModel>((ref) {
  return ApiHealthDashboardNotifier()..loadData();
});
