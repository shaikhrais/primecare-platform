import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TrainingHubAnalyticsScreenState
    extends DashboardState<TrainingHubAnalyticsScreenState> {
  TrainingHubAnalyticsScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  TrainingHubAnalyticsScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => TrainingHubAnalyticsScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class TrainingHubAnalyticsScreenController
    extends BaseDashboardController<TrainingHubAnalyticsScreenState> {
  TrainingHubAnalyticsScreenController(Ref ref)
    : super(
        ref,
        initialState: TrainingHubAnalyticsScreenState(
          isLoading: true,
          data: {},
        ),
        endpoint: '/common/training-hub-analytics',
      );
}

final training_hub_analyticsControllerProvider =
    StateNotifierProvider<
      TrainingHubAnalyticsScreenController,
      TrainingHubAnalyticsScreenState
    >((ref) {
      return TrainingHubAnalyticsScreenController(ref);
    });
