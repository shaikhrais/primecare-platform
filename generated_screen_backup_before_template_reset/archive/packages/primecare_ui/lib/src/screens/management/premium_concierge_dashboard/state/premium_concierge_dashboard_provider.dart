import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/premium_concierge_dashboard_model.dart';

class PremiumConciergeDashboardNotifier extends StateNotifier<PremiumConciergeDashboardModel> {
  PremiumConciergeDashboardNotifier() : super(const PremiumConciergeDashboardModel(isLoading: true));

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

final premium_concierge_dashboardProvider = StateNotifierProvider<PremiumConciergeDashboardNotifier, PremiumConciergeDashboardModel>((ref) {
  return PremiumConciergeDashboardNotifier()..loadData();
});
