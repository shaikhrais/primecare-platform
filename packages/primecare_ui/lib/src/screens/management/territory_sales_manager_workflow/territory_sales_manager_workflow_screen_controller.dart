import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TerritorySalesManagerWorkflowScreenState {
  final bool isLoading;
  final String? error;
  final Map<String, dynamic> data;

  TerritorySalesManagerWorkflowScreenState({required this.isLoading, this.error, required this.data});

  TerritorySalesManagerWorkflowScreenState copyWith({bool? isLoading, String? error, Map<String, dynamic>? data}) {
    return TerritorySalesManagerWorkflowScreenState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      data: data ?? this.data,
    );
  }
}

class TerritorySalesManagerWorkflowScreenController extends StateNotifier<TerritorySalesManagerWorkflowScreenState> {
  final Ref ref;
  TerritorySalesManagerWorkflowScreenController(this.ref) : super(TerritorySalesManagerWorkflowScreenState(isLoading: true, data: {})) {
    loadDashboardData();
  }

  Future<void> loadDashboardData() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final response = await ref.read(apiClientProvider).get('/management/territory-sales-manager-workflow');
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

final territory_sales_manager_workflowControllerProvider = StateNotifierProvider<TerritorySalesManagerWorkflowScreenController, TerritorySalesManagerWorkflowScreenState>((ref) {
  return TerritorySalesManagerWorkflowScreenController(ref);
});
