import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TerritoryExpansionManagerWorkflowScreenState {
  final bool isLoading;
  final String? error;
  final Map<String, dynamic> data;

  TerritoryExpansionManagerWorkflowScreenState({required this.isLoading, this.error, required this.data});

  TerritoryExpansionManagerWorkflowScreenState copyWith({bool? isLoading, String? error, Map<String, dynamic>? data}) {
    return TerritoryExpansionManagerWorkflowScreenState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      data: data ?? this.data,
    );
  }
}

class TerritoryExpansionManagerWorkflowScreenController extends StateNotifier<TerritoryExpansionManagerWorkflowScreenState> {
  final Ref ref;
  TerritoryExpansionManagerWorkflowScreenController(this.ref) : super(TerritoryExpansionManagerWorkflowScreenState(isLoading: true, data: {})) {
    loadDashboardData();
  }

  Future<void> loadDashboardData() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final response = await ref.read(apiClientProvider).get('/management/territory-expansion-manager-workflow');
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

final territory_expansion_manager_workflowControllerProvider = StateNotifierProvider<TerritoryExpansionManagerWorkflowScreenController, TerritoryExpansionManagerWorkflowScreenState>((ref) {
  return TerritoryExpansionManagerWorkflowScreenController(ref);
});
