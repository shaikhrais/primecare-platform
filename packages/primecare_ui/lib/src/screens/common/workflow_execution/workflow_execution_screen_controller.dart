import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WorkflowExecutionScreenState {
  final bool isLoading;
  final String? error;
  final Map<String, dynamic> data;

  WorkflowExecutionScreenState({required this.isLoading, this.error, required this.data});

  WorkflowExecutionScreenState copyWith({bool? isLoading, String? error, Map<String, dynamic>? data}) {
    return WorkflowExecutionScreenState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      data: data ?? this.data,
    );
  }
}

class WorkflowExecutionScreenController extends StateNotifier<WorkflowExecutionScreenState> {
  final Ref ref;
  WorkflowExecutionScreenController(this.ref) : super(WorkflowExecutionScreenState(isLoading: true, data: {})) {
    loadDashboardData();
  }

  Future<void> loadDashboardData() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final response = await ref.read(apiClientProvider).get('/common/workflow-execution');
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

final workflow_executionControllerProvider = StateNotifierProvider<WorkflowExecutionScreenController, WorkflowExecutionScreenState>((ref) {
  return WorkflowExecutionScreenController(ref);
});
