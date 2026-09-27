import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/community_outreach_dashboard_model.dart';

class CommunityOutreachDashboardNotifier extends StateNotifier<CommunityOutreachDashboardModel> {
  CommunityOutreachDashboardNotifier() : super(const CommunityOutreachDashboardModel(isLoading: true));

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

final community_outreach_dashboardProvider = StateNotifierProvider<CommunityOutreachDashboardNotifier, CommunityOutreachDashboardModel>((ref) {
  return CommunityOutreachDashboardNotifier()..loadData();
});
