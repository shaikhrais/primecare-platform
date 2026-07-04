import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/psw_care_dashboard_model.dart';

class PswCareDashboardNotifier extends StateNotifier<PswCareDashboardModel> {
  PswCareDashboardNotifier() : super(const PswCareDashboardModel(isLoading: true));

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

final psw_care_dashboardProvider = StateNotifierProvider<PswCareDashboardNotifier, PswCareDashboardModel>((ref) {
  return PswCareDashboardNotifier()..loadData();
});
