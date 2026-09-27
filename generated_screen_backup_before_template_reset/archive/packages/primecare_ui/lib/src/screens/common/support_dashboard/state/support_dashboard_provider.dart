import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/support_dashboard_model.dart';

class SupportDashboardNotifier extends StateNotifier<SupportDashboardModel> {
  SupportDashboardNotifier() : super(const SupportDashboardModel(isLoading: true));

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

final support_dashboardProvider = StateNotifierProvider<SupportDashboardNotifier, SupportDashboardModel>((ref) {
  return SupportDashboardNotifier()..loadData();
});
