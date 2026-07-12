import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/guest_dashboard_model.dart';

class GuestDashboardNotifier extends StateNotifier<GuestDashboardModel> {
  GuestDashboardNotifier() : super(const GuestDashboardModel(isLoading: true));

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

final guest_dashboardProvider = StateNotifierProvider<GuestDashboardNotifier, GuestDashboardModel>((ref) {
  return GuestDashboardNotifier()..loadData();
});
