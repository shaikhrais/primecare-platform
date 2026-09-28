import 'package:flutter_riverpod/legacy.dart';
import '../models/family_dashboard_model.dart';

class FamilyDashboardNotifier extends StateNotifier<FamilyDashboardModel> {
  FamilyDashboardNotifier() : super(const FamilyDashboardModel(isLoading: true));

  Future<void> loadData() async {
    state = state.copyWith(isLoading: true);
    try {
      // TODO: Call API service
      state = state.copyWith(isLoading: false, data: const <String, dynamic>{});
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.toString());
    }
  }
}

final family_dashboardProvider = StateNotifierProvider<FamilyDashboardNotifier, FamilyDashboardModel>((ref) {
  return FamilyDashboardNotifier()..loadData();
});
