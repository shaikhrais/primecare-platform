import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/head_of_marketing_dashboard_model.dart';

class HeadOfMarketingDashboardNotifier extends StateNotifier<HeadOfMarketingDashboardModel> {
  HeadOfMarketingDashboardNotifier() : super(const HeadOfMarketingDashboardModel(isLoading: true));

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

final head_of_marketing_dashboardProvider = StateNotifierProvider<HeadOfMarketingDashboardNotifier, HeadOfMarketingDashboardModel>((ref) {
  return HeadOfMarketingDashboardNotifier()..loadData();
});
