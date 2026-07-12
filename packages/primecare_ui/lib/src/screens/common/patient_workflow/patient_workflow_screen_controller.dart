import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PatientWorkflowScreenState {
  final bool isLoading;
  final String? error;
  final Map<String, dynamic> data;

  PatientWorkflowScreenState({required this.isLoading, this.error, required this.data});

  PatientWorkflowScreenState copyWith({bool? isLoading, String? error, Map<String, dynamic>? data}) {
    return PatientWorkflowScreenState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      data: data ?? this.data,
    );
  }
}

class PatientWorkflowScreenController extends StateNotifier<PatientWorkflowScreenState> {
  final Ref ref;
  PatientWorkflowScreenController(this.ref) : super(PatientWorkflowScreenState(isLoading: true, data: {})) {
    loadDashboardData();
  }

  Future<void> loadDashboardData() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final response = await ref.read(apiClientProvider).get('/common/patient-workflow');
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

final patient_workflowControllerProvider = StateNotifierProvider<PatientWorkflowScreenController, PatientWorkflowScreenState>((ref) {
  return PatientWorkflowScreenController(ref);
});
