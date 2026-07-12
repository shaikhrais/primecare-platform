import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class OperationsManagerWorkflowScreenState {
  final bool isLoading;
  final String? error;
  final Map<String, dynamic> data;

  OperationsManagerWorkflowScreenState({required this.isLoading, this.error, required this.data});

  OperationsManagerWorkflowScreenState copyWith({bool? isLoading, String? error, Map<String, dynamic>? data}) {
    return OperationsManagerWorkflowScreenState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      data: data ?? this.data,
    );
  }
}

class OperationsManagerWorkflowScreenController extends StateNotifier<OperationsManagerWorkflowScreenState> {
  final Ref ref;
  OperationsManagerWorkflowScreenController(this.ref) : super(OperationsManagerWorkflowScreenState(isLoading: true, data: {})) {
    loadDashboardData();
  }

  Future<void> loadDashboardData() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final response = await ref.read(apiClientProvider).get('/management/operations-manager-workflow');
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

final operations_manager_workflowControllerProvider = StateNotifierProvider<OperationsManagerWorkflowScreenController, OperationsManagerWorkflowScreenState>((ref) {
  return OperationsManagerWorkflowScreenController(ref);
});
