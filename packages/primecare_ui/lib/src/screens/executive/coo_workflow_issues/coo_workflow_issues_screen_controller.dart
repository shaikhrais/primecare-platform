import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CooWorkflowIssuesScreenState {
  final bool isLoading;
  final String? error;
  final Map<String, dynamic> data;

  CooWorkflowIssuesScreenState({required this.isLoading, this.error, required this.data});

  CooWorkflowIssuesScreenState copyWith({bool? isLoading, String? error, Map<String, dynamic>? data}) {
    return CooWorkflowIssuesScreenState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      data: data ?? this.data,
    );
  }
}

class CooWorkflowIssuesScreenController extends StateNotifier<CooWorkflowIssuesScreenState> {
  final Ref ref;
  CooWorkflowIssuesScreenController(this.ref) : super(CooWorkflowIssuesScreenState(isLoading: true, data: {})) {
    loadDashboardData();
  }

  Future<void> loadDashboardData() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final response = await ref.read(apiClientProvider).get('/executive/coo-workflow-issues');
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

final coo_workflow_issuesControllerProvider = StateNotifierProvider<CooWorkflowIssuesScreenController, CooWorkflowIssuesScreenState>((ref) {
  return CooWorkflowIssuesScreenController(ref);
});
