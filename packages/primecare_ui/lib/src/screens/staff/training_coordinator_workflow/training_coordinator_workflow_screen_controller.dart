import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TrainingCoordinatorWorkflowScreenState
    extends DashboardState<TrainingCoordinatorWorkflowScreenState> {
  TrainingCoordinatorWorkflowScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  TrainingCoordinatorWorkflowScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => TrainingCoordinatorWorkflowScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class TrainingCoordinatorWorkflowScreenController
    extends BaseDashboardController<TrainingCoordinatorWorkflowScreenState> {
  TrainingCoordinatorWorkflowScreenController(Ref ref)
    : super(
        ref,
        initialState: TrainingCoordinatorWorkflowScreenState(
          isLoading: true,
          data: {},
        ),
        endpoint: '/staff/training-coordinator-workflow',
      );
}

final training_coordinator_workflowControllerProvider =
    StateNotifierProvider<
      TrainingCoordinatorWorkflowScreenController,
      TrainingCoordinatorWorkflowScreenState
    >((ref) {
      return TrainingCoordinatorWorkflowScreenController(ref);
    });
