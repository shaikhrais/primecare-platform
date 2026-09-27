import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/rmt_dashboard_model.dart';

class RmtDashboardNotifier extends StateNotifier<RmtDashboardModel> {
  RmtDashboardNotifier() : super(const RmtDashboardModel(isLoading: true));

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

final rmt_dashboardProvider = StateNotifierProvider<RmtDashboardNotifier, RmtDashboardModel>((ref) {
  return RmtDashboardNotifier()..loadData();
});
