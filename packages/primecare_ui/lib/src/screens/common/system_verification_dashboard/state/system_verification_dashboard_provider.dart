import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/system_verification_dashboard_model.dart';

class SystemVerificationDashboardNotifier extends StateNotifier<SystemVerificationDashboardModel> {
  SystemVerificationDashboardNotifier() : super(const SystemVerificationDashboardModel(isLoading: true));

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

final system_verification_dashboardProvider = StateNotifierProvider<SystemVerificationDashboardNotifier, SystemVerificationDashboardModel>((ref) {
  return SystemVerificationDashboardNotifier()..loadData();
});
