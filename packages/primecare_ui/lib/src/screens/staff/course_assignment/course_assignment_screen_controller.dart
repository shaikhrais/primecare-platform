import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CourseAssignmentScreenState
    extends DashboardState<CourseAssignmentScreenState> {
  CourseAssignmentScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  CourseAssignmentScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => CourseAssignmentScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class CourseAssignmentScreenController
    extends BaseDashboardController<CourseAssignmentScreenState> {
  CourseAssignmentScreenController(Ref ref)
    : super(
        ref,
        initialState: CourseAssignmentScreenState(isLoading: true, data: {}),
        endpoint: '/staff/course-assignment',
      );
}

final course_assignmentControllerProvider =
    StateNotifierProvider<
      CourseAssignmentScreenController,
      CourseAssignmentScreenState
    >((ref) {
      return CourseAssignmentScreenController(ref);
    });
