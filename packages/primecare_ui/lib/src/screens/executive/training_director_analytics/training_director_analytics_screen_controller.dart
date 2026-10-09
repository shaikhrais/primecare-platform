import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TrainingDirectorAnalyticsScreenState
    extends DashboardState<TrainingDirectorAnalyticsScreenState> {
  TrainingDirectorAnalyticsScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  TrainingDirectorAnalyticsScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => TrainingDirectorAnalyticsScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class TrainingDirectorAnalyticsScreenController
    extends BaseDashboardController<TrainingDirectorAnalyticsScreenState> {
  TrainingDirectorAnalyticsScreenController(Ref ref)
    : super(
        ref,
        initialState: TrainingDirectorAnalyticsScreenState(
          isLoading: true,
          data: {},
        ),
        endpoint: '/offices/corporate/roles/training_director/analytics',
      );
}

final training_director_analyticsControllerProvider =
    StateNotifierProvider<
      TrainingDirectorAnalyticsScreenController,
      TrainingDirectorAnalyticsScreenState
    >((ref) {
      return TrainingDirectorAnalyticsScreenController(ref);
    });
