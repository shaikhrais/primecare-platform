import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/rn_dashboard_model.dart';

class RnDashboardNotifier extends StateNotifier<RnDashboardModel> {
  RnDashboardNotifier() : super(const RnDashboardModel(isLoading: true));

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

final rn_dashboardProvider = StateNotifierProvider<RnDashboardNotifier, RnDashboardModel>((ref) {
  return RnDashboardNotifier()..loadData();
});
