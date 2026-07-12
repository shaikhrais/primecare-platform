import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NursePractitionerNpComplianceWorkflowScreenState {
  final bool isLoading;
  final String? error;
  final Map<String, dynamic> data;

  NursePractitionerNpComplianceWorkflowScreenState({required this.isLoading, this.error, required this.data});

  NursePractitionerNpComplianceWorkflowScreenState copyWith({bool? isLoading, String? error, Map<String, dynamic>? data}) {
    return NursePractitionerNpComplianceWorkflowScreenState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      data: data ?? this.data,
    );
  }
}

class NursePractitionerNpComplianceWorkflowScreenController extends StateNotifier<NursePractitionerNpComplianceWorkflowScreenState> {
  final Ref ref;
  NursePractitionerNpComplianceWorkflowScreenController(this.ref) : super(NursePractitionerNpComplianceWorkflowScreenState(isLoading: true, data: {})) {
    loadDashboardData();
  }

  Future<void> loadDashboardData() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final response = await ref.read(apiClientProvider).get('/rn/np-workflow');
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

final np_workflowControllerProvider = StateNotifierProvider<NursePractitionerNpComplianceWorkflowScreenController, NursePractitionerNpComplianceWorkflowScreenState>((ref) {
  return NursePractitionerNpComplianceWorkflowScreenController(ref);
});
