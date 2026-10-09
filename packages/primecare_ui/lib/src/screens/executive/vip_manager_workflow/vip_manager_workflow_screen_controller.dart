import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class VipClientManagerComplianceWorkflowScreenState
    extends DashboardState<VipClientManagerComplianceWorkflowScreenState> {
  VipClientManagerComplianceWorkflowScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  VipClientManagerComplianceWorkflowScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => VipClientManagerComplianceWorkflowScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class VipClientManagerComplianceWorkflowScreenController
    extends
        BaseDashboardController<VipClientManagerComplianceWorkflowScreenState> {
  VipClientManagerComplianceWorkflowScreenController(Ref ref)
    : super(
        ref,
        initialState: VipClientManagerComplianceWorkflowScreenState(
          isLoading: true,
          data: {},
        ),
        endpoint: '/executive/vip-manager-workflow',
      );
}

final vip_manager_workflowControllerProvider =
    StateNotifierProvider<
      VipClientManagerComplianceWorkflowScreenController,
      VipClientManagerComplianceWorkflowScreenState
    >((ref) {
      return VipClientManagerComplianceWorkflowScreenController(ref);
    });
