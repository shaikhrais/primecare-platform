import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CisoWorkflowScreenState {
  final bool isLoading;
  final String? error;
  final Map<String, dynamic> data;

  CisoWorkflowScreenState({required this.isLoading, this.error, required this.data});

  CisoWorkflowScreenState copyWith({bool? isLoading, String? error, Map<String, dynamic>? data}) {
    return CisoWorkflowScreenState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      data: data ?? this.data,
    );
  }
}

class CisoWorkflowScreenController extends StateNotifier<CisoWorkflowScreenState> {
  final Ref ref;
  CisoWorkflowScreenController(this.ref) : super(CisoWorkflowScreenState(isLoading: true, data: {})) {
    loadDashboardData();
  }

  Future<void> loadDashboardData() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final response = await ref.read(apiClientProvider).get('/executive/ciso-workflow');
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

final ciso_workflowControllerProvider = StateNotifierProvider<CisoWorkflowScreenController, CisoWorkflowScreenState>((ref) {
  return CisoWorkflowScreenController(ref);
});
