import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/cto_dashboard_model.dart';

class CtoDashboardNotifier extends StateNotifier<CtoDashboardModel> {
  CtoDashboardNotifier() : super(const CtoDashboardModel(isLoading: true));

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

final cto_dashboardProvider = StateNotifierProvider<CtoDashboardNotifier, CtoDashboardModel>((ref) {
  return CtoDashboardNotifier()..loadData();
});
