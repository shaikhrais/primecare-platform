import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RoleCoverageDashboardScreenState {
  final bool isLoading;
  final String? error;
  final Map<String, dynamic> data;

  RoleCoverageDashboardScreenState({required this.isLoading, this.error, required this.data});

  RoleCoverageDashboardScreenState copyWith({bool? isLoading, String? error, Map<String, dynamic>? data}) {
    return RoleCoverageDashboardScreenState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      data: data ?? this.data,
    );
  }
}

class RoleCoverageDashboardScreenController extends StateNotifier<RoleCoverageDashboardScreenState> {
  final Ref ref;
  RoleCoverageDashboardScreenController(this.ref) : super(RoleCoverageDashboardScreenState(isLoading: true, data: {})) {
    loadDashboardData();
  }

  Future<void> loadDashboardData() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final response = await ref.read(apiClientProvider).get('/common/role-coverage-dashboard');
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

final role_coverage_dashboardControllerProvider = StateNotifierProvider<RoleCoverageDashboardScreenController, RoleCoverageDashboardScreenState>((ref) {
  return RoleCoverageDashboardScreenController(ref);
});
