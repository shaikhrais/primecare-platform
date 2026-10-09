import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HrManagerWorkflowScreenState
    extends DashboardState<HrManagerWorkflowScreenState> {
  HrManagerWorkflowScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  HrManagerWorkflowScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => HrManagerWorkflowScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class HrManagerWorkflowScreenController
    extends BaseDashboardController<HrManagerWorkflowScreenState> {
  HrManagerWorkflowScreenController(Ref ref)
    : super(
        ref,
        initialState: HrManagerWorkflowScreenState(isLoading: true, data: {}),
        endpoint: '/staff/hr-manager-workflow',
      );
}

final hr_manager_workflowControllerProvider =
    StateNotifierProvider<
      HrManagerWorkflowScreenController,
      HrManagerWorkflowScreenState
    >((ref) {
      return HrManagerWorkflowScreenController(ref);
    });
