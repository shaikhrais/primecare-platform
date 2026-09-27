import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/physiotherapist_dashboard_model.dart';

class PhysiotherapistDashboardNotifier extends StateNotifier<PhysiotherapistDashboardModel> {
  PhysiotherapistDashboardNotifier() : super(const PhysiotherapistDashboardModel(isLoading: true));

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

final physiotherapist_dashboardProvider = StateNotifierProvider<PhysiotherapistDashboardNotifier, PhysiotherapistDashboardModel>((ref) {
  return PhysiotherapistDashboardNotifier()..loadData();
});
