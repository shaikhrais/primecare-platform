import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class IntakeDashboardScreenState {
  final bool isLoading;
  final String? error;
  final Map<String, dynamic> data;

  IntakeDashboardScreenState({required this.isLoading, this.error, required this.data});

  IntakeDashboardScreenState copyWith({bool? isLoading, String? error, Map<String, dynamic>? data}) {
    return IntakeDashboardScreenState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      data: data ?? this.data,
    );
  }
}

class IntakeDashboardScreenController extends StateNotifier<IntakeDashboardScreenState> {
  final Ref ref;
  IntakeDashboardScreenController(this.ref) : super(IntakeDashboardScreenState(isLoading: true, data: {})) {
    loadDashboardData();
  }

  Future<void> loadDashboardData() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final response = await ref.read(apiClientProvider).get('/offices/clinical/roles/intake_coordinator/dashboard-dup-1');
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

final intake_dashboardControllerProvider = StateNotifierProvider<IntakeDashboardScreenController, IntakeDashboardScreenState>((ref) {
  return IntakeDashboardScreenController(ref);
});
