import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/office_dashboard_model.dart';

class OfficeDashboardNotifier extends StateNotifier<OfficeDashboardModel> {
  OfficeDashboardNotifier() : super(const OfficeDashboardModel(isLoading: true));

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

final office_dashboardProvider = StateNotifierProvider<OfficeDashboardNotifier, OfficeDashboardModel>((ref) {
  return OfficeDashboardNotifier()..loadData();
});
