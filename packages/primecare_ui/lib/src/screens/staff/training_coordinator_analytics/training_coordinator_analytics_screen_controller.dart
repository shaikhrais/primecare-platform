import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TrainingCoordinatorAnalyticsScreenState
    extends DashboardState<TrainingCoordinatorAnalyticsScreenState> {
  TrainingCoordinatorAnalyticsScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  TrainingCoordinatorAnalyticsScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => TrainingCoordinatorAnalyticsScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class TrainingCoordinatorAnalyticsScreenController
    extends BaseDashboardController<TrainingCoordinatorAnalyticsScreenState> {
  TrainingCoordinatorAnalyticsScreenController(Ref ref)
    : super(
        ref,
        initialState: TrainingCoordinatorAnalyticsScreenState(
          isLoading: true,
          data: {},
        ),
        endpoint: '/staff/training-coordinator-analytics',
      );
}

final training_coordinator_analyticsControllerProvider =
    StateNotifierProvider<
      TrainingCoordinatorAnalyticsScreenController,
      TrainingCoordinatorAnalyticsScreenState
    >((ref) {
      return TrainingCoordinatorAnalyticsScreenController(ref);
    });
