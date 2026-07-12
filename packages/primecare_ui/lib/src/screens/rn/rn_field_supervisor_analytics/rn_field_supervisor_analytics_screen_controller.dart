import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RegisteredNurseRnFieldSupervisorAnalyticsScreenState {
  final bool isLoading;
  final String? error;
  final Map<String, dynamic> data;

  RegisteredNurseRnFieldSupervisorAnalyticsScreenState({required this.isLoading, this.error, required this.data});

  RegisteredNurseRnFieldSupervisorAnalyticsScreenState copyWith({bool? isLoading, String? error, Map<String, dynamic>? data}) {
    return RegisteredNurseRnFieldSupervisorAnalyticsScreenState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      data: data ?? this.data,
    );
  }
}

class RegisteredNurseRnFieldSupervisorAnalyticsScreenController extends StateNotifier<RegisteredNurseRnFieldSupervisorAnalyticsScreenState> {
  final Ref ref;
  RegisteredNurseRnFieldSupervisorAnalyticsScreenController(this.ref) : super(RegisteredNurseRnFieldSupervisorAnalyticsScreenState(isLoading: true, data: {})) {
    loadDashboardData();
  }

  Future<void> loadDashboardData() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final response = await ref.read(apiClientProvider).get('/rn/rn-field-supervisor-analytics');
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

final rn_field_supervisor_analyticsControllerProvider = StateNotifierProvider<RegisteredNurseRnFieldSupervisorAnalyticsScreenController, RegisteredNurseRnFieldSupervisorAnalyticsScreenState>((ref) {
  return RegisteredNurseRnFieldSupervisorAnalyticsScreenController(ref);
});
