import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TrainingDirectorComplianceScreenState
    extends DashboardState<TrainingDirectorComplianceScreenState> {
  TrainingDirectorComplianceScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  TrainingDirectorComplianceScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => TrainingDirectorComplianceScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class TrainingDirectorComplianceScreenController
    extends BaseDashboardController<TrainingDirectorComplianceScreenState> {
  TrainingDirectorComplianceScreenController(Ref ref)
    : super(
        ref,
        initialState: TrainingDirectorComplianceScreenState(
          isLoading: true,
          data: {},
        ),
        endpoint: '/executive/training-director-compliance',
      );
}

final training_director_complianceControllerProvider =
    StateNotifierProvider<
      TrainingDirectorComplianceScreenController,
      TrainingDirectorComplianceScreenState
    >((ref) {
      return TrainingDirectorComplianceScreenController(ref);
    });
