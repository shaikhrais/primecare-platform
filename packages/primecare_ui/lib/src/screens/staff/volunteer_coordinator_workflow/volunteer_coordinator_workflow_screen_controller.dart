import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class VolunteerCoordinatorWorkflowScreenState
    extends DashboardState<VolunteerCoordinatorWorkflowScreenState> {
  VolunteerCoordinatorWorkflowScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  VolunteerCoordinatorWorkflowScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => VolunteerCoordinatorWorkflowScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class VolunteerCoordinatorWorkflowScreenController
    extends BaseDashboardController<VolunteerCoordinatorWorkflowScreenState> {
  VolunteerCoordinatorWorkflowScreenController(Ref ref)
    : super(
        ref,
        initialState: VolunteerCoordinatorWorkflowScreenState(
          isLoading: true,
          data: {},
        ),
        endpoint: '/staff/volunteer-coordinator-workflow',
      );
}

final volunteer_coordinator_workflowControllerProvider =
    StateNotifierProvider<
      VolunteerCoordinatorWorkflowScreenController,
      VolunteerCoordinatorWorkflowScreenState
    >((ref) {
      return VolunteerCoordinatorWorkflowScreenController(ref);
    });
