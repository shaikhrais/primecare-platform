import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/receptionist_dashboard_model.dart';

class ReceptionistDashboardNotifier extends StateNotifier<ReceptionistDashboardModel> {
  ReceptionistDashboardNotifier() : super(const ReceptionistDashboardModel(isLoading: true));

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

final receptionist_dashboardProvider = StateNotifierProvider<ReceptionistDashboardNotifier, ReceptionistDashboardModel>((ref) {
  return ReceptionistDashboardNotifier()..loadData();
});
