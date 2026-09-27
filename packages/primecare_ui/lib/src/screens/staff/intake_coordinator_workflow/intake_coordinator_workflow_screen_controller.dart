import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class IntakeCoordinatorWorkflowScreenState {
  final bool isLoading;
  final String? error;
  final Map<String, dynamic> data;

  IntakeCoordinatorWorkflowScreenState({required this.isLoading, this.error, required this.data});

  IntakeCoordinatorWorkflowScreenState copyWith({bool? isLoading, String? error, Map<String, dynamic>? data}) {
    return IntakeCoordinatorWorkflowScreenState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      data: data ?? this.data,
    );
  }
}

class IntakeCoordinatorWorkflowScreenController extends StateNotifier<IntakeCoordinatorWorkflowScreenState> {
  final Ref ref;
  IntakeCoordinatorWorkflowScreenController(this.ref) : super(IntakeCoordinatorWorkflowScreenState(isLoading: true, data: {})) {
    loadDashboardData();
  }

  Future<void> loadDashboardData() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final response = await ref.read(apiClientProvider).get('/offices/clinical/roles/intake_coordinator/coordinator-workflow');
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

final intake_coordinator_workflowControllerProvider = StateNotifierProvider<IntakeCoordinatorWorkflowScreenController, IntakeCoordinatorWorkflowScreenState>((ref) {
  return IntakeCoordinatorWorkflowScreenController(ref);
});
