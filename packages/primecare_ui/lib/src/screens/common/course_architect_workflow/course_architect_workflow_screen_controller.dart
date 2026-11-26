import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CourseArchitectWorkflowScreenState
    extends DashboardState<CourseArchitectWorkflowScreenState> {
  CourseArchitectWorkflowScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  CourseArchitectWorkflowScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => CourseArchitectWorkflowScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class CourseArchitectWorkflowScreenController
    extends BaseDashboardController<CourseArchitectWorkflowScreenState> {
  CourseArchitectWorkflowScreenController(Ref ref)
    : super(
        ref,
        initialState: CourseArchitectWorkflowScreenState(
          isLoading: true,
          data: {},
        ),
        endpoint: '/common/course-architect-workflow',
      );
}

final course_architect_workflowControllerProvider =
    StateNotifierProvider<
      CourseArchitectWorkflowScreenController,
      CourseArchitectWorkflowScreenState
    >((ref) {
      return CourseArchitectWorkflowScreenController(ref);
    });
