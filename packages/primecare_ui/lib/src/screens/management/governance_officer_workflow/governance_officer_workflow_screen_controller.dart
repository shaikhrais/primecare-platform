import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GovernanceOfficerWorkflowScreenState {
  final bool isLoading;
  final String? error;
  final Map<String, dynamic> data;

  GovernanceOfficerWorkflowScreenState({required this.isLoading, this.error, required this.data});

  GovernanceOfficerWorkflowScreenState copyWith({bool? isLoading, String? error, Map<String, dynamic>? data}) {
    return GovernanceOfficerWorkflowScreenState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      data: data ?? this.data,
    );
  }
}

class GovernanceOfficerWorkflowScreenController extends StateNotifier<GovernanceOfficerWorkflowScreenState> {
  final Ref ref;
  GovernanceOfficerWorkflowScreenController(this.ref) : super(GovernanceOfficerWorkflowScreenState(isLoading: true, data: {})) {
    loadDashboardData();
  }

  Future<void> loadDashboardData() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final response = await ref.read(apiClientProvider).get('/management/governance-officer-workflow');
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

final governance_officer_workflowControllerProvider = StateNotifierProvider<GovernanceOfficerWorkflowScreenController, GovernanceOfficerWorkflowScreenState>((ref) {
  return GovernanceOfficerWorkflowScreenController(ref);
});
