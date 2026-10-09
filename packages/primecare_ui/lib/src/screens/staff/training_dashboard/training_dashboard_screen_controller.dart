import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TrainingDashboardScreenState
    extends DashboardState<TrainingDashboardScreenState> {
  TrainingDashboardScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  TrainingDashboardScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => TrainingDashboardScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class TrainingDashboardScreenController
    extends BaseDashboardController<TrainingDashboardScreenState> {
  TrainingDashboardScreenController(Ref ref)
    : super(
        ref,
        initialState: TrainingDashboardScreenState(isLoading: true, data: {}),
        endpoint: '/staff/training-dashboard',
      );
}

final training_dashboardControllerProvider =
    StateNotifierProvider<
      TrainingDashboardScreenController,
      TrainingDashboardScreenState
    >((ref) {
      return TrainingDashboardScreenController(ref);
    });
