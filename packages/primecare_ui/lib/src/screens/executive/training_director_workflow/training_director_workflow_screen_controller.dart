import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TrainingDirectorWorkflowScreenState
    extends DashboardState<TrainingDirectorWorkflowScreenState> {
  TrainingDirectorWorkflowScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  TrainingDirectorWorkflowScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => TrainingDirectorWorkflowScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class TrainingDirectorWorkflowScreenController
    extends BaseDashboardController<TrainingDirectorWorkflowScreenState> {
  TrainingDirectorWorkflowScreenController(Ref ref)
    : super(
        ref,
        initialState: TrainingDirectorWorkflowScreenState(
          isLoading: true,
          data: {},
        ),
        endpoint: '/executive/training-director-workflow',
      );
}

final training_director_workflowControllerProvider =
    StateNotifierProvider<
      TrainingDirectorWorkflowScreenController,
      TrainingDirectorWorkflowScreenState
    >((ref) {
      return TrainingDirectorWorkflowScreenController(ref);
    });
