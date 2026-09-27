import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FranchiseSalesManagerWorkflowScreenState {
  final bool isLoading;
  final String? error;
  final Map<String, dynamic> data;

  FranchiseSalesManagerWorkflowScreenState({required this.isLoading, this.error, required this.data});

  FranchiseSalesManagerWorkflowScreenState copyWith({bool? isLoading, String? error, Map<String, dynamic>? data}) {
    return FranchiseSalesManagerWorkflowScreenState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      data: data ?? this.data,
    );
  }
}

class FranchiseSalesManagerWorkflowScreenController extends StateNotifier<FranchiseSalesManagerWorkflowScreenState> {
  final Ref ref;
  FranchiseSalesManagerWorkflowScreenController(this.ref) : super(FranchiseSalesManagerWorkflowScreenState(isLoading: true, data: {})) {
    loadDashboardData();
  }

  Future<void> loadDashboardData() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final response = await ref.read(apiClientProvider).get('/management/franchise-sales-manager-workflow');
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

final franchise_sales_manager_workflowControllerProvider = StateNotifierProvider<FranchiseSalesManagerWorkflowScreenController, FranchiseSalesManagerWorkflowScreenState>((ref) {
  return FranchiseSalesManagerWorkflowScreenController(ref);
});
