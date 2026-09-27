import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/rpn_dashboard_model.dart';

class RpnDashboardNotifier extends StateNotifier<RpnDashboardModel> {
  RpnDashboardNotifier() : super(const RpnDashboardModel(isLoading: true));

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

final rpn_dashboardProvider = StateNotifierProvider<RpnDashboardNotifier, RpnDashboardModel>((ref) {
  return RpnDashboardNotifier()..loadData();
});
