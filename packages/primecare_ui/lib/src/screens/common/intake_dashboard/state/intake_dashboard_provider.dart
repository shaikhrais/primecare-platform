import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/intake_dashboard_model.dart';

class IntakeDashboardNotifier extends StateNotifier<IntakeDashboardModel> {
  IntakeDashboardNotifier() : super(const IntakeDashboardModel(isLoading: true));

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

final intake_dashboardProvider = StateNotifierProvider<IntakeDashboardNotifier, IntakeDashboardModel>((ref) {
  return IntakeDashboardNotifier()..loadData();
});
