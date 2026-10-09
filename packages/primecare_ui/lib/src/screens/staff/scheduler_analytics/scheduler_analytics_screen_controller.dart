import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SchedulerAnalyticsScreenState
    extends DashboardState<SchedulerAnalyticsScreenState> {
  SchedulerAnalyticsScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  SchedulerAnalyticsScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => SchedulerAnalyticsScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class SchedulerAnalyticsScreenController
    extends BaseDashboardController<SchedulerAnalyticsScreenState> {
  SchedulerAnalyticsScreenController(Ref ref)
    : super(
        ref,
        initialState: SchedulerAnalyticsScreenState(isLoading: true, data: {}),
        endpoint: '/staff/scheduler-analytics',
      );
}

final scheduler_analyticsControllerProvider =
    StateNotifierProvider<
      SchedulerAnalyticsScreenController,
      SchedulerAnalyticsScreenState
    >((ref) {
      return SchedulerAnalyticsScreenController(ref);
    });
