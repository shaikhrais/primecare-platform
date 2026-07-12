import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TherapistComplianceWorkflowScreenState {
  final bool isLoading;
  final String? error;
  final Map<String, dynamic> data;

  TherapistComplianceWorkflowScreenState({required this.isLoading, this.error, required this.data});

  TherapistComplianceWorkflowScreenState copyWith({bool? isLoading, String? error, Map<String, dynamic>? data}) {
    return TherapistComplianceWorkflowScreenState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      data: data ?? this.data,
    );
  }
}

class TherapistComplianceWorkflowScreenController extends StateNotifier<TherapistComplianceWorkflowScreenState> {
  final Ref ref;
  TherapistComplianceWorkflowScreenController(this.ref) : super(TherapistComplianceWorkflowScreenState(isLoading: true, data: {})) {
    loadDashboardData();
  }

  Future<void> loadDashboardData() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final response = await ref.read(apiClientProvider).get('/offices/clinical/roles/therapist/workflow');
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

final therapist_workflowControllerProvider = StateNotifierProvider<TherapistComplianceWorkflowScreenController, TherapistComplianceWorkflowScreenState>((ref) {
  return TherapistComplianceWorkflowScreenController(ref);
});
