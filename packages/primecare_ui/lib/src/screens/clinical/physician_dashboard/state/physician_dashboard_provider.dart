import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/physician_dashboard_model.dart';

class PhysicianDashboardNotifier extends StateNotifier<PhysicianDashboardModel> {
  PhysicianDashboardNotifier() : super(const PhysicianDashboardModel(isLoading: true));

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

final physician_dashboardProvider = StateNotifierProvider<PhysicianDashboardNotifier, PhysicianDashboardModel>((ref) {
  return PhysicianDashboardNotifier()..loadData();
});
