import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/psw_dashboard_model.dart';

class PswDashboardNotifier extends StateNotifier<PswDashboardModel> {
  PswDashboardNotifier() : super(const PswDashboardModel(isLoading: true));

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

final psw_dashboardProvider = StateNotifierProvider<PswDashboardNotifier, PswDashboardModel>((ref) {
  return PswDashboardNotifier()..loadData();
});
