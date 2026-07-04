import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/cfo_dashboard_model.dart';

class CfoDashboardNotifier extends StateNotifier<CfoDashboardModel> {
  CfoDashboardNotifier() : super(const CfoDashboardModel(isLoading: true));

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

final cfo_dashboardProvider = StateNotifierProvider<CfoDashboardNotifier, CfoDashboardModel>((ref) {
  return CfoDashboardNotifier()..loadData();
});
