import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TrainingCoordinatorComplianceScreenState
    extends DashboardState<TrainingCoordinatorComplianceScreenState> {
  TrainingCoordinatorComplianceScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  TrainingCoordinatorComplianceScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => TrainingCoordinatorComplianceScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class TrainingCoordinatorComplianceScreenController
    extends BaseDashboardController<TrainingCoordinatorComplianceScreenState> {
  TrainingCoordinatorComplianceScreenController(Ref ref)
    : super(
        ref,
        initialState: TrainingCoordinatorComplianceScreenState(
          isLoading: true,
          data: {},
        ),
        endpoint: '/staff/training-coordinator-compliance',
      );
}

final training_coordinator_complianceControllerProvider =
    StateNotifierProvider<
      TrainingCoordinatorComplianceScreenController,
      TrainingCoordinatorComplianceScreenState
    >((ref) {
      return TrainingCoordinatorComplianceScreenController(ref);
    });
