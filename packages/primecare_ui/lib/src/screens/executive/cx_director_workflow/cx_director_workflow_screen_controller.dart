import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CxDirectorWorkflowScreenState {
  final bool isLoading;
  final String? error;
  final Map<String, dynamic> data;

  CxDirectorWorkflowScreenState({required this.isLoading, this.error, required this.data});

  CxDirectorWorkflowScreenState copyWith({bool? isLoading, String? error, Map<String, dynamic>? data}) {
    return CxDirectorWorkflowScreenState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      data: data ?? this.data,
    );
  }
}

class CxDirectorWorkflowScreenController extends StateNotifier<CxDirectorWorkflowScreenState> {
  final Ref ref;
  CxDirectorWorkflowScreenController(this.ref) : super(CxDirectorWorkflowScreenState(isLoading: true, data: {})) {
    loadDashboardData();
  }

  Future<void> loadDashboardData() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final response = await ref.read(apiClientProvider).get('/executive/cx-director-workflow');
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

final cx_director_workflowControllerProvider = StateNotifierProvider<CxDirectorWorkflowScreenController, CxDirectorWorkflowScreenState>((ref) {
  return CxDirectorWorkflowScreenController(ref);
});
