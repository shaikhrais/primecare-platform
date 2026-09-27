import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class VipClientManagerComplianceWorkflowScreenState {
  final bool isLoading;
  final String? error;
  final Map<String, dynamic> data;

  VipClientManagerComplianceWorkflowScreenState({required this.isLoading, this.error, required this.data});

  VipClientManagerComplianceWorkflowScreenState copyWith({bool? isLoading, String? error, Map<String, dynamic>? data}) {
    return VipClientManagerComplianceWorkflowScreenState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      data: data ?? this.data,
    );
  }
}

class VipClientManagerComplianceWorkflowScreenController extends StateNotifier<VipClientManagerComplianceWorkflowScreenState> {
  final Ref ref;
  VipClientManagerComplianceWorkflowScreenController(this.ref) : super(VipClientManagerComplianceWorkflowScreenState(isLoading: true, data: {})) {
    loadDashboardData();
  }

  Future<void> loadDashboardData() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final response = await ref.read(apiClientProvider).get('/executive/vip-manager-workflow');
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

final vip_manager_workflowControllerProvider = StateNotifierProvider<VipClientManagerComplianceWorkflowScreenController, VipClientManagerComplianceWorkflowScreenState>((ref) {
  return VipClientManagerComplianceWorkflowScreenController(ref);
});
