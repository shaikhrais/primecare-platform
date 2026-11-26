import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HrHiringWorkflowScreenState
    extends DashboardState<HrHiringWorkflowScreenState> {
  HrHiringWorkflowScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  HrHiringWorkflowScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => HrHiringWorkflowScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class HrHiringWorkflowScreenController
    extends BaseDashboardController<HrHiringWorkflowScreenState> {
  HrHiringWorkflowScreenController(Ref ref)
    : super(
        ref,
        initialState: HrHiringWorkflowScreenState(isLoading: true, data: {}),
        endpoint: '/staff/hr-hiring-workflow',
      );
}

final hr_hiring_workflowControllerProvider =
    StateNotifierProvider<
      HrHiringWorkflowScreenController,
      HrHiringWorkflowScreenState
    >((ref) {
      return HrHiringWorkflowScreenController(ref);
    });
