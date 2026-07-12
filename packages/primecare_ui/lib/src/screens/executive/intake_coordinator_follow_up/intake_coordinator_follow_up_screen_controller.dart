import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class IntakeCoordinatorFollowUpScreenState {
  final bool isLoading;
  final String? error;
  final Map<String, dynamic> data;

  IntakeCoordinatorFollowUpScreenState({required this.isLoading, this.error, required this.data});

  IntakeCoordinatorFollowUpScreenState copyWith({bool? isLoading, String? error, Map<String, dynamic>? data}) {
    return IntakeCoordinatorFollowUpScreenState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      data: data ?? this.data,
    );
  }
}

class IntakeCoordinatorFollowUpScreenController extends StateNotifier<IntakeCoordinatorFollowUpScreenState> {
  final Ref ref;
  IntakeCoordinatorFollowUpScreenController(this.ref) : super(IntakeCoordinatorFollowUpScreenState(isLoading: true, data: {})) {
    loadDashboardData();
  }

  Future<void> loadDashboardData() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final response = await ref.read(apiClientProvider).get('/executive/intake-coordinator-follow-up');
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

final intake_coordinator_follow_upControllerProvider = StateNotifierProvider<IntakeCoordinatorFollowUpScreenController, IntakeCoordinatorFollowUpScreenState>((ref) {
  return IntakeCoordinatorFollowUpScreenController(ref);
});
