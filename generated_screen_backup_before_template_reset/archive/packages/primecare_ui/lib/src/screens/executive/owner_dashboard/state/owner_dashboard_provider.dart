import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/owner_dashboard_model.dart';

class OwnerDashboardNotifier extends StateNotifier<OwnerDashboardModel> {
  OwnerDashboardNotifier() : super(const OwnerDashboardModel(isLoading: true));

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

final owner_dashboardProvider = StateNotifierProvider<OwnerDashboardNotifier, OwnerDashboardModel>((ref) {
  return OwnerDashboardNotifier()..loadData();
});
