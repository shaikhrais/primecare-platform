import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/legal_dashboard_model.dart';

class LegalDashboardNotifier extends StateNotifier<LegalDashboardModel> {
  LegalDashboardNotifier() : super(const LegalDashboardModel(isLoading: true));

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

final legal_dashboardProvider = StateNotifierProvider<LegalDashboardNotifier, LegalDashboardModel>((ref) {
  return LegalDashboardNotifier()..loadData();
});
