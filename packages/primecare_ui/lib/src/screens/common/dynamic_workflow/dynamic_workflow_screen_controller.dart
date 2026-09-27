import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DynamicScreenWorkflowScreenState {
  final bool isLoading;
  final String? error;
  final Map<String, dynamic> data;

  DynamicScreenWorkflowScreenState({required this.isLoading, this.error, required this.data});

  DynamicScreenWorkflowScreenState copyWith({bool? isLoading, String? error, Map<String, dynamic>? data}) {
    return DynamicScreenWorkflowScreenState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      data: data ?? this.data,
    );
  }
}

class DynamicScreenWorkflowScreenController extends StateNotifier<DynamicScreenWorkflowScreenState> {
  final Ref ref;
  DynamicScreenWorkflowScreenController(this.ref) : super(DynamicScreenWorkflowScreenState(isLoading: true, data: {})) {
    loadDashboardData();
  }

  Future<void> loadDashboardData() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final response = await ref.read(apiClientProvider).get('/common/dynamic-workflow');
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

final dynamic_workflowControllerProvider = StateNotifierProvider<DynamicScreenWorkflowScreenController, DynamicScreenWorkflowScreenState>((ref) {
  return DynamicScreenWorkflowScreenController(ref);
});
