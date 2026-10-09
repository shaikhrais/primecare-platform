import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SchedulingDashboardScreenState
    extends DashboardState<SchedulingDashboardScreenState> {
  SchedulingDashboardScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  SchedulingDashboardScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => SchedulingDashboardScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class SchedulingDashboardScreenController
    extends BaseDashboardController<SchedulingDashboardScreenState> {
  SchedulingDashboardScreenController(Ref ref)
    : super(
        ref,
        initialState: SchedulingDashboardScreenState(isLoading: true, data: {}),
        endpoint: '/staff/scheduling-dashboard',
      );
}

final scheduling_dashboardControllerProvider =
    StateNotifierProvider<
      SchedulingDashboardScreenController,
      SchedulingDashboardScreenState
    >((ref) {
      return SchedulingDashboardScreenController(ref);
    });
