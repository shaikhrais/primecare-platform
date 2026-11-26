import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TrainingHubComplianceScreenState
    extends DashboardState<TrainingHubComplianceScreenState> {
  TrainingHubComplianceScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  TrainingHubComplianceScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => TrainingHubComplianceScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class TrainingHubComplianceScreenController
    extends BaseDashboardController<TrainingHubComplianceScreenState> {
  TrainingHubComplianceScreenController(Ref ref)
    : super(
        ref,
        initialState: TrainingHubComplianceScreenState(
          isLoading: true,
          data: {},
        ),
        endpoint: '/common/training-hub-compliance',
      );
}

final training_hub_complianceControllerProvider =
    StateNotifierProvider<
      TrainingHubComplianceScreenController,
      TrainingHubComplianceScreenState
    >((ref) {
      return TrainingHubComplianceScreenController(ref);
    });
