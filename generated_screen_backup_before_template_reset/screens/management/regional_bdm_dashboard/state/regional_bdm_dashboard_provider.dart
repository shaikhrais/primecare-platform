import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/regional_bdm_dashboard_model.dart';

class RegionalBdmDashboardNotifier extends StateNotifier<RegionalBdmDashboardModel> {
  RegionalBdmDashboardNotifier() : super(const RegionalBdmDashboardModel(isLoading: true));

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

final regional_bdm_dashboardProvider = StateNotifierProvider<RegionalBdmDashboardNotifier, RegionalBdmDashboardModel>((ref) {
  return RegionalBdmDashboardNotifier()..loadData();
});
