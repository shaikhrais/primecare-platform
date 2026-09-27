import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/np_dashboard_model.dart';

class NpDashboardNotifier extends StateNotifier<NpDashboardModel> {
  NpDashboardNotifier() : super(const NpDashboardModel(isLoading: true));

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

final np_dashboardProvider = StateNotifierProvider<NpDashboardNotifier, NpDashboardModel>((ref) {
  return NpDashboardNotifier()..loadData();
});
