import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CourseArchitectComplianceScreenState
    extends DashboardState<CourseArchitectComplianceScreenState> {
  CourseArchitectComplianceScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  CourseArchitectComplianceScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => CourseArchitectComplianceScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class CourseArchitectComplianceScreenController
    extends BaseDashboardController<CourseArchitectComplianceScreenState> {
  CourseArchitectComplianceScreenController(Ref ref)
    : super(
        ref,
        initialState: CourseArchitectComplianceScreenState(
          isLoading: true,
          data: {},
        ),
        endpoint: '/common/course-architect-compliance',
      );
}

final course_architect_complianceControllerProvider =
    StateNotifierProvider<
      CourseArchitectComplianceScreenController,
      CourseArchitectComplianceScreenState
    >((ref) {
      return CourseArchitectComplianceScreenController(ref);
    });
