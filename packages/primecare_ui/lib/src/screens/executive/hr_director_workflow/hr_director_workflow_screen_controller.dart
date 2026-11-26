import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HrDirectorWorkflowScreenState
    extends DashboardState<HrDirectorWorkflowScreenState> {
  HrDirectorWorkflowScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  HrDirectorWorkflowScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => HrDirectorWorkflowScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class HrDirectorWorkflowScreenController
    extends BaseDashboardController<HrDirectorWorkflowScreenState> {
  HrDirectorWorkflowScreenController(Ref ref)
    : super(
        ref,
        initialState: HrDirectorWorkflowScreenState(isLoading: true, data: {}),
        endpoint: '/executive/hr-director-workflow',
      );
}

final hr_director_workflowControllerProvider =
    StateNotifierProvider<
      HrDirectorWorkflowScreenController,
      HrDirectorWorkflowScreenState
    >((ref) {
      return HrDirectorWorkflowScreenController(ref);
    });
