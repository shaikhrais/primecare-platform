import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/lpn_dashboard_model.dart';

class LpnDashboardNotifier extends StateNotifier<LpnDashboardModel> {
  LpnDashboardNotifier() : super(const LpnDashboardModel(isLoading: true));

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

final lpn_dashboardProvider = StateNotifierProvider<LpnDashboardNotifier, LpnDashboardModel>((ref) {
  return LpnDashboardNotifier()..loadData();
});
