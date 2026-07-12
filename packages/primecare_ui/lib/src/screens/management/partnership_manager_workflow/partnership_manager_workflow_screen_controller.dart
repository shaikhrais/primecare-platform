import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PartnershipManagerWorkflowScreenState {
  final bool isLoading;
  final String? error;
  final Map<String, dynamic> data;

  PartnershipManagerWorkflowScreenState({required this.isLoading, this.error, required this.data});

  PartnershipManagerWorkflowScreenState copyWith({bool? isLoading, String? error, Map<String, dynamic>? data}) {
    return PartnershipManagerWorkflowScreenState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      data: data ?? this.data,
    );
  }
}

class PartnershipManagerWorkflowScreenController extends StateNotifier<PartnershipManagerWorkflowScreenState> {
  final Ref ref;
  PartnershipManagerWorkflowScreenController(this.ref) : super(PartnershipManagerWorkflowScreenState(isLoading: true, data: {})) {
    loadDashboardData();
  }

  Future<void> loadDashboardData() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final response = await ref.read(apiClientProvider).get('/management/partnership-manager-workflow');
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

final partnership_manager_workflowControllerProvider = StateNotifierProvider<PartnershipManagerWorkflowScreenController, PartnershipManagerWorkflowScreenState>((ref) {
  return PartnershipManagerWorkflowScreenController(ref);
});
