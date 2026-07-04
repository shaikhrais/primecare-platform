import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/social_worker_dashboard_model.dart';

class SocialWorkerDashboardNotifier extends StateNotifier<SocialWorkerDashboardModel> {
  SocialWorkerDashboardNotifier() : super(const SocialWorkerDashboardModel(isLoading: true));

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

final social_worker_dashboardProvider = StateNotifierProvider<SocialWorkerDashboardNotifier, SocialWorkerDashboardModel>((ref) {
  return SocialWorkerDashboardNotifier()..loadData();
});
