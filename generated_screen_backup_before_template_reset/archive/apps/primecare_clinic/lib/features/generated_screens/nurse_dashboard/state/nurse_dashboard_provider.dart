import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/nurse_dashboard_model.dart';

class NurseDashboardNotifier extends StateNotifier<NurseDashboardModel> {
  NurseDashboardNotifier() : super(const NurseDashboardModel(isLoading: true));

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

final nurse_dashboardProvider = StateNotifierProvider<NurseDashboardNotifier, NurseDashboardModel>((ref) {
  return NurseDashboardNotifier()..loadData();
});
