import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ArchitecturePlanningAnalyticsScreenState
    extends DashboardState<ArchitecturePlanningAnalyticsScreenState> {
  ArchitecturePlanningAnalyticsScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  ArchitecturePlanningAnalyticsScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => ArchitecturePlanningAnalyticsScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class ArchitecturePlanningAnalyticsScreenController
    extends BaseDashboardController<ArchitecturePlanningAnalyticsScreenState> {
  ArchitecturePlanningAnalyticsScreenController(Ref ref)
    : super(
        ref,
        initialState: ArchitecturePlanningAnalyticsScreenState(
          isLoading: true,
          data: {},
        ),
        endpoint: '/common/architecture-planning-analytics',
      );
}

final architecture_planning_analyticsControllerProvider =
    StateNotifierProvider<
      ArchitecturePlanningAnalyticsScreenController,
      ArchitecturePlanningAnalyticsScreenState
    >((ref) {
      return ArchitecturePlanningAnalyticsScreenController(ref);
    });
