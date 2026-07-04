import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/employee_dashboard_model.dart';

class EmployeeDashboardNotifier extends StateNotifier<EmployeeDashboardModel> {
  EmployeeDashboardNotifier() : super(const EmployeeDashboardModel(isLoading: true));

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

final employee_dashboardProvider = StateNotifierProvider<EmployeeDashboardNotifier, EmployeeDashboardModel>((ref) {
  return EmployeeDashboardNotifier()..loadData();
});
