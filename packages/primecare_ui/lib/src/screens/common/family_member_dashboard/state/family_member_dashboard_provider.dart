import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/family_member_dashboard_model.dart';

class FamilyMemberDashboardNotifier extends StateNotifier<FamilyMemberDashboardModel> {
  FamilyMemberDashboardNotifier() : super(const FamilyMemberDashboardModel(isLoading: true));

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

final family_member_dashboardProvider = StateNotifierProvider<FamilyMemberDashboardNotifier, FamilyMemberDashboardModel>((ref) {
  return FamilyMemberDashboardNotifier()..loadData();
});
