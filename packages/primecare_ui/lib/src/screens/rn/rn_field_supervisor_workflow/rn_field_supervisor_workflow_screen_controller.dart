import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RegisteredNurseRnFieldSupervisorComplianceWorkflowScreenState {
  final bool isLoading;
  final String? error;
  final Map<String, dynamic> data;

  RegisteredNurseRnFieldSupervisorComplianceWorkflowScreenState({required this.isLoading, this.error, required this.data});

  RegisteredNurseRnFieldSupervisorComplianceWorkflowScreenState copyWith({bool? isLoading, String? error, Map<String, dynamic>? data}) {
    return RegisteredNurseRnFieldSupervisorComplianceWorkflowScreenState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      data: data ?? this.data,
    );
  }
}

class RegisteredNurseRnFieldSupervisorComplianceWorkflowScreenController extends StateNotifier<RegisteredNurseRnFieldSupervisorComplianceWorkflowScreenState> {
  final Ref ref;
  RegisteredNurseRnFieldSupervisorComplianceWorkflowScreenController(this.ref) : super(RegisteredNurseRnFieldSupervisorComplianceWorkflowScreenState(isLoading: true, data: {})) {
    loadDashboardData();
  }

  Future<void> loadDashboardData() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final response = await ref.read(apiClientProvider).get('/rn/rn-field-supervisor-workflow');
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

final rn_field_supervisor_workflowControllerProvider = StateNotifierProvider<RegisteredNurseRnFieldSupervisorComplianceWorkflowScreenController, RegisteredNurseRnFieldSupervisorComplianceWorkflowScreenState>((ref) {
  return RegisteredNurseRnFieldSupervisorComplianceWorkflowScreenController(ref);
});
