import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HrDirectorWorkflowScreenState {
  final bool isLoading;
  final String? error;
  final Map<String, dynamic> data;

  HrDirectorWorkflowScreenState({required this.isLoading, this.error, required this.data});

  HrDirectorWorkflowScreenState copyWith({bool? isLoading, String? error, Map<String, dynamic>? data}) {
    return HrDirectorWorkflowScreenState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      data: data ?? this.data,
    );
  }
}

class HrDirectorWorkflowScreenController extends StateNotifier<HrDirectorWorkflowScreenState> {
  final Ref ref;
  HrDirectorWorkflowScreenController(this.ref) : super(HrDirectorWorkflowScreenState(isLoading: true, data: {})) {
    loadDashboardData();
  }

  Future<void> loadDashboardData() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final response = await ref.read(apiClientProvider).get('/executive/hr-director-workflow');
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

final hr_director_workflowControllerProvider = StateNotifierProvider<HrDirectorWorkflowScreenController, HrDirectorWorkflowScreenState>((ref) {
  return HrDirectorWorkflowScreenController(ref);
});
