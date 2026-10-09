import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TrainingDirectorDashboardScreenState
    extends DashboardState<TrainingDirectorDashboardScreenState> {
  TrainingDirectorDashboardScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  TrainingDirectorDashboardScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => TrainingDirectorDashboardScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class TrainingDirectorDashboardScreenController
    extends BaseDashboardController<TrainingDirectorDashboardScreenState> {
  TrainingDirectorDashboardScreenController(Ref ref)
    : super(
        ref,
        initialState: TrainingDirectorDashboardScreenState(
          isLoading: true,
          data: {},
        ),
        endpoint: '/offices/corporate/roles/training_director/dashboard',
      );
}

final training_director_dashboardControllerProvider =
    StateNotifierProvider<
      TrainingDirectorDashboardScreenController,
      TrainingDirectorDashboardScreenState
    >((ref) {
      return TrainingDirectorDashboardScreenController(ref);
    });
