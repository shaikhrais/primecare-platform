import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/infrastructure_dashboard_model.dart';

class InfrastructureDashboardNotifier extends StateNotifier<InfrastructureDashboardModel> {
  InfrastructureDashboardNotifier() : super(const InfrastructureDashboardModel(isLoading: true));

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

final infrastructure_dashboardProvider = StateNotifierProvider<InfrastructureDashboardNotifier, InfrastructureDashboardModel>((ref) {
  return InfrastructureDashboardNotifier()..loadData();
});
