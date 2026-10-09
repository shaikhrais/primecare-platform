import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NursePractitionerNpComplianceWorkflowScreenState
    extends DashboardState<NursePractitionerNpComplianceWorkflowScreenState> {
  NursePractitionerNpComplianceWorkflowScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  NursePractitionerNpComplianceWorkflowScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => NursePractitionerNpComplianceWorkflowScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class NursePractitionerNpComplianceWorkflowScreenController
    extends
        BaseDashboardController<
          NursePractitionerNpComplianceWorkflowScreenState
        > {
  NursePractitionerNpComplianceWorkflowScreenController(Ref ref)
    : super(
        ref,
        initialState: NursePractitionerNpComplianceWorkflowScreenState(
          isLoading: true,
          data: {},
        ),
        endpoint: '/rn/np-workflow',
      );
}

final np_workflowControllerProvider =
    StateNotifierProvider<
      NursePractitionerNpComplianceWorkflowScreenController,
      NursePractitionerNpComplianceWorkflowScreenState
    >((ref) {
      return NursePractitionerNpComplianceWorkflowScreenController(ref);
    });
