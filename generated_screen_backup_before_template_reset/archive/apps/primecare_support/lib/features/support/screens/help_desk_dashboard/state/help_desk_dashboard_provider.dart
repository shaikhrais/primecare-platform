import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/help_desk_dashboard_model.dart';

class HelpDeskDashboardNotifier extends StateNotifier<HelpDeskDashboardModel> {
  HelpDeskDashboardNotifier() : super(const HelpDeskDashboardModel(isLoading: true));

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

final help_desk_dashboardProvider = StateNotifierProvider<HelpDeskDashboardNotifier, HelpDeskDashboardModel>((ref) {
  return HelpDeskDashboardNotifier()..loadData();
});
