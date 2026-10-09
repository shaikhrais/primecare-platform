import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TrainingHubDashboardScreenState
    extends DashboardState<TrainingHubDashboardScreenState> {
  TrainingHubDashboardScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  TrainingHubDashboardScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => TrainingHubDashboardScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class TrainingHubDashboardScreenController
    extends BaseDashboardController<TrainingHubDashboardScreenState> {
  TrainingHubDashboardScreenController(Ref ref)
    : super(
        ref,
        initialState: TrainingHubDashboardScreenState(
          isLoading: true,
          data: {},
        ),
        endpoint: '/common/training-hub-dashboard',
      );
}

final training_hub_dashboardControllerProvider =
    StateNotifierProvider<
      TrainingHubDashboardScreenController,
      TrainingHubDashboardScreenState
    >((ref) {
      return TrainingHubDashboardScreenController(ref);
    });
