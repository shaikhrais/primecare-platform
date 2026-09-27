import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/shareholder_dashboard_model.dart';

class ShareholderDashboardNotifier extends StateNotifier<ShareholderDashboardModel> {
  ShareholderDashboardNotifier() : super(const ShareholderDashboardModel(isLoading: true));

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

final shareholder_dashboardProvider = StateNotifierProvider<ShareholderDashboardNotifier, ShareholderDashboardModel>((ref) {
  return ShareholderDashboardNotifier()..loadData();
});
