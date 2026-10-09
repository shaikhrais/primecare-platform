import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TrainingCoordinatorDashboardScreenState
    extends DashboardState<TrainingCoordinatorDashboardScreenState> {
  TrainingCoordinatorDashboardScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  TrainingCoordinatorDashboardScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => TrainingCoordinatorDashboardScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class TrainingCoordinatorDashboardScreenController
    extends BaseDashboardController<TrainingCoordinatorDashboardScreenState> {
  TrainingCoordinatorDashboardScreenController(Ref ref)
    : super(
        ref,
        initialState: TrainingCoordinatorDashboardScreenState(
          isLoading: true,
          data: {},
        ),
        endpoint: '/offices/support/roles/training_coordinator/dashboard',
      );
}

final training_coordinator_dashboardControllerProvider =
    StateNotifierProvider<
      TrainingCoordinatorDashboardScreenController,
      TrainingCoordinatorDashboardScreenState
    >((ref) {
      return TrainingCoordinatorDashboardScreenController(ref);
    });
