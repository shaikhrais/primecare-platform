import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CourseArchitectAnalyticsScreenState
    extends DashboardState<CourseArchitectAnalyticsScreenState> {
  CourseArchitectAnalyticsScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  CourseArchitectAnalyticsScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => CourseArchitectAnalyticsScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class CourseArchitectAnalyticsScreenController
    extends BaseDashboardController<CourseArchitectAnalyticsScreenState> {
  CourseArchitectAnalyticsScreenController(Ref ref)
    : super(
        ref,
        initialState: CourseArchitectAnalyticsScreenState(
          isLoading: true,
          data: {},
        ),
        endpoint: '/common/course-architect-analytics',
      );
}

final course_architect_analyticsControllerProvider =
    StateNotifierProvider<
      CourseArchitectAnalyticsScreenController,
      CourseArchitectAnalyticsScreenState
    >((ref) {
      return CourseArchitectAnalyticsScreenController(ref);
    });
