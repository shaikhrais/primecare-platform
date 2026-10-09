import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CourseArchitectDashboardScreenState
    extends DashboardState<CourseArchitectDashboardScreenState> {
  CourseArchitectDashboardScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  CourseArchitectDashboardScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => CourseArchitectDashboardScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class CourseArchitectDashboardScreenController
    extends BaseDashboardController<CourseArchitectDashboardScreenState> {
  CourseArchitectDashboardScreenController(Ref ref)
    : super(
        ref,
        initialState: CourseArchitectDashboardScreenState(
          isLoading: true,
          data: {},
        ),
        endpoint: '/common/course-architect-dashboard',
      );
}

final course_architect_dashboardControllerProvider =
    StateNotifierProvider<
      CourseArchitectDashboardScreenController,
      CourseArchitectDashboardScreenState
    >((ref) {
      return CourseArchitectDashboardScreenController(ref);
    });
