import 'package:flutter_riverpod/legacy.dart';
import '../models/help_desk_dashboard_model.dart';

class HelpDeskDashboardNotifier extends StateNotifier<HelpDeskDashboardModel> {
  HelpDeskDashboardNotifier() : super(const HelpDeskDashboardModel(isLoading: true));

  Future<void> loadData() async {
    if (!mounted) return;
    state = state.copyWith(isLoading: true);
    try {
      // No authorized dashboard service is connected to this legacy provider.
      if (!mounted) return;
      state = state.copyWith(isLoading: false,
        errorMessage: 'Help Desk data unavailable: service binding required.');
    } catch (e) {
      if (!mounted) return;
      state = state.copyWith(isLoading: false, errorMessage: e.toString());
    }
  }
}

final help_desk_dashboardProvider = StateNotifierProvider<HelpDeskDashboardNotifier, HelpDeskDashboardModel>((ref) {
  return HelpDeskDashboardNotifier()..loadData();
});
