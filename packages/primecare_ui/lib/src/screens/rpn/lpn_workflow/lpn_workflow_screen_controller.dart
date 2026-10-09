import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LicensedPracticalNurseLpnComplianceWorkflowScreenState
    extends
        DashboardState<LicensedPracticalNurseLpnComplianceWorkflowScreenState> {
  LicensedPracticalNurseLpnComplianceWorkflowScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  LicensedPracticalNurseLpnComplianceWorkflowScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => LicensedPracticalNurseLpnComplianceWorkflowScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class LicensedPracticalNurseLpnComplianceWorkflowScreenController
    extends
        BaseDashboardController<
          LicensedPracticalNurseLpnComplianceWorkflowScreenState
        > {
  LicensedPracticalNurseLpnComplianceWorkflowScreenController(Ref ref)
    : super(
        ref,
        initialState: LicensedPracticalNurseLpnComplianceWorkflowScreenState(
          isLoading: true,
          data: {},
        ),
        endpoint: '/rpn/lpn-workflow',
      );
}

final lpn_workflowControllerProvider =
    StateNotifierProvider<
      LicensedPracticalNurseLpnComplianceWorkflowScreenController,
      LicensedPracticalNurseLpnComplianceWorkflowScreenState
    >((ref) {
      return LicensedPracticalNurseLpnComplianceWorkflowScreenController(ref);
    });
