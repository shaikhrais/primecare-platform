import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/client_dashboard_model.dart';

class ClientDashboardNotifier extends StateNotifier<ClientDashboardModel> {
  ClientDashboardNotifier() : super(const ClientDashboardModel(isLoading: true));

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

final client_dashboardProvider = StateNotifierProvider<ClientDashboardNotifier, ClientDashboardModel>((ref) {
  return ClientDashboardNotifier()..loadData();
});
