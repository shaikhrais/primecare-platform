import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/local_marketing_manager_dashboard_model.dart';

class LocalMarketingManagerDashboardNotifier extends StateNotifier<LocalMarketingManagerDashboardModel> {
  LocalMarketingManagerDashboardNotifier() : super(const LocalMarketingManagerDashboardModel(isLoading: true));

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

final local_marketing_manager_dashboardProvider = StateNotifierProvider<LocalMarketingManagerDashboardNotifier, LocalMarketingManagerDashboardModel>((ref) {
  return LocalMarketingManagerDashboardNotifier()..loadData();
});
