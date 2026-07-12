import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EmployeeDashboardScreenState {
  final bool isLoading;
  final String? error;
  final Map<String, dynamic> data;

  EmployeeDashboardScreenState({required this.isLoading, this.error, required this.data});

  EmployeeDashboardScreenState copyWith({bool? isLoading, String? error, Map<String, dynamic>? data}) {
    return EmployeeDashboardScreenState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      data: data ?? this.data,
    );
  }
}

class EmployeeDashboardScreenController extends StateNotifier<EmployeeDashboardScreenState> {
  final Ref ref;
  EmployeeDashboardScreenController(this.ref) : super(EmployeeDashboardScreenState(isLoading: true, data: {})) {
    loadDashboardData();
  }

  Future<void> loadDashboardData() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final response = await ref.read(apiClientProvider).get('/staff/employee-dashboard');
      if (response.isSuccess) {
        state = state.copyWith(
          isLoading: false,
          data: response.data is Map ? Map<String, dynamic>.from(response.data) : {},
        );
      } else {
        state = state.copyWith(
          isLoading: false,
          error: response.error ?? 'Failed to load live data',
        );
      }
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Future<void> syncData() async {
    await loadDashboardData();
  }
}

final employee_dashboardControllerProvider = StateNotifierProvider<EmployeeDashboardScreenController, EmployeeDashboardScreenState>((ref) {
  return EmployeeDashboardScreenController(ref);
});
