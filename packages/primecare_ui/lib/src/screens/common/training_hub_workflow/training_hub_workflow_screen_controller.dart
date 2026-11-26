import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TrainingHubWorkflowScreenState
    extends DashboardState<TrainingHubWorkflowScreenState> {
  TrainingHubWorkflowScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  TrainingHubWorkflowScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => TrainingHubWorkflowScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class TrainingHubWorkflowScreenController
    extends BaseDashboardController<TrainingHubWorkflowScreenState> {
  TrainingHubWorkflowScreenController(Ref ref)
    : super(
        ref,
        initialState: TrainingHubWorkflowScreenState(isLoading: true, data: {}),
        endpoint: '/common/training-hub-workflow',
      );
}

final training_hub_workflowControllerProvider =
    StateNotifierProvider<
      TrainingHubWorkflowScreenController,
      TrainingHubWorkflowScreenState
    >((ref) {
      return TrainingHubWorkflowScreenController(ref);
    });
