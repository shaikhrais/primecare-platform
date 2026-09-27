import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EmployeeAnalyticsScreenState {
  final bool isLoading;
  final String? error;
  final Map<String, dynamic> data;

  EmployeeAnalyticsScreenState({required this.isLoading, this.error, required this.data});

  EmployeeAnalyticsScreenState copyWith({bool? isLoading, String? error, Map<String, dynamic>? data}) {
    return EmployeeAnalyticsScreenState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      data: data ?? this.data,
    );
  }
}

class EmployeeAnalyticsScreenController extends StateNotifier<EmployeeAnalyticsScreenState> {
  final Ref ref;
  EmployeeAnalyticsScreenController(this.ref) : super(EmployeeAnalyticsScreenState(isLoading: true, data: {})) {
    loadDashboardData();
  }

  Future<void> loadDashboardData() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final response = await ref.read(apiClientProvider).get('/staff/employee-analytics');
      if (response.isSuccess) {
        final responseData = response.data;
        state = state.copyWith(
          isLoading: false,
          data: responseData is Map ? Map<String, dynamic>.from(responseData) : {},
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

final employee_analyticsControllerProvider = StateNotifierProvider<EmployeeAnalyticsScreenController, EmployeeAnalyticsScreenState>((ref) {
  return EmployeeAnalyticsScreenController(ref);
});
