import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RnFieldSupervisorDashboardScreenState {
  final bool isLoading;
  final String? error;
  final Map<String, dynamic> data;

  RnFieldSupervisorDashboardScreenState({required this.isLoading, this.error, required this.data});

  RnFieldSupervisorDashboardScreenState copyWith({bool? isLoading, String? error, Map<String, dynamic>? data}) {
    return RnFieldSupervisorDashboardScreenState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      data: data ?? this.data,
    );
  }
}

class RnFieldSupervisorDashboardScreenController extends StateNotifier<RnFieldSupervisorDashboardScreenState> {
  final Ref ref;
  RnFieldSupervisorDashboardScreenController(this.ref) : super(RnFieldSupervisorDashboardScreenState(isLoading: true, data: {})) {
    loadDashboardData();
  }

  Future<void> loadDashboardData() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final response = await ref.read(apiClientProvider).get('/rn/rn-field-supervisor-dashboard');
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

final rn_field_supervisor_dashboardControllerProvider = StateNotifierProvider<RnFieldSupervisorDashboardScreenController, RnFieldSupervisorDashboardScreenState>((ref) {
  return RnFieldSupervisorDashboardScreenController(ref);
});
