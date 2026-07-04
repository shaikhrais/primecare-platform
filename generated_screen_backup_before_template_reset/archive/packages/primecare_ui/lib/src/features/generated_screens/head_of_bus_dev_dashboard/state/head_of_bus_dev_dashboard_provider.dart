import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/head_of_bus_dev_dashboard_model.dart';

class HeadOfBusDevDashboardNotifier extends StateNotifier<HeadOfBusDevDashboardModel> {
  HeadOfBusDevDashboardNotifier() : super(const HeadOfBusDevDashboardModel(isLoading: true));

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

final head_of_bus_dev_dashboardProvider = StateNotifierProvider<HeadOfBusDevDashboardNotifier, HeadOfBusDevDashboardModel>((ref) {
  return HeadOfBusDevDashboardNotifier()..loadData();
});
