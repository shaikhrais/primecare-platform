import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HeadOfBusDevWorkflowScreenState {
  final bool isLoading;
  final String? error;
  final Map<String, dynamic> data;

  HeadOfBusDevWorkflowScreenState({required this.isLoading, this.error, required this.data});

  HeadOfBusDevWorkflowScreenState copyWith({bool? isLoading, String? error, Map<String, dynamic>? data}) {
    return HeadOfBusDevWorkflowScreenState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      data: data ?? this.data,
    );
  }
}

class HeadOfBusDevWorkflowScreenController extends StateNotifier<HeadOfBusDevWorkflowScreenState> {
  final Ref ref;
  HeadOfBusDevWorkflowScreenController(this.ref) : super(HeadOfBusDevWorkflowScreenState(isLoading: true, data: {})) {
    loadDashboardData();
  }

  Future<void> loadDashboardData() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final response = await ref.read(apiClientProvider).get('/management/head-of-bus-dev-workflow');
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

final head_of_bus_dev_workflowControllerProvider = StateNotifierProvider<HeadOfBusDevWorkflowScreenController, HeadOfBusDevWorkflowScreenState>((ref) {
  return HeadOfBusDevWorkflowScreenController(ref);
});
