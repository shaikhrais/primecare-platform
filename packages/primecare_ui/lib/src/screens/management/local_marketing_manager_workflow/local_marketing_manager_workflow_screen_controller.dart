import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LocalMarketingManagerWorkflowScreenState {
  final bool isLoading;
  final String? error;
  final Map<String, dynamic> data;

  LocalMarketingManagerWorkflowScreenState({required this.isLoading, this.error, required this.data});

  LocalMarketingManagerWorkflowScreenState copyWith({bool? isLoading, String? error, Map<String, dynamic>? data}) {
    return LocalMarketingManagerWorkflowScreenState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      data: data ?? this.data,
    );
  }
}

class LocalMarketingManagerWorkflowScreenController extends StateNotifier<LocalMarketingManagerWorkflowScreenState> {
  final Ref ref;
  LocalMarketingManagerWorkflowScreenController(this.ref) : super(LocalMarketingManagerWorkflowScreenState(isLoading: true, data: {})) {
    loadDashboardData();
  }

  Future<void> loadDashboardData() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final response = await ref.read(apiClientProvider).get('/management/local-marketing-manager-workflow');
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

final local_marketing_manager_workflowControllerProvider = StateNotifierProvider<LocalMarketingManagerWorkflowScreenController, LocalMarketingManagerWorkflowScreenState>((ref) {
  return LocalMarketingManagerWorkflowScreenController(ref);
});
