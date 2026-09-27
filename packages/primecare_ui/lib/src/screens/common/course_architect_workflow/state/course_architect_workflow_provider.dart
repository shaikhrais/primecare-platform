import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/course_architect_workflow_model.dart';

class CourseArchitectWorkflowNotifier extends StateNotifier<CourseArchitectWorkflowModel> {
  CourseArchitectWorkflowNotifier() : super(const CourseArchitectWorkflowModel(isLoading: true));

  Future<void> loadData() async {
    state = state.copyWith(isLoading: true);
    try {
      // TODO: Call API service
      state = state.copyWith(isLoading: false, data: const {});
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.toString());
    }
  }
}

final course_architect_workflowProvider = StateNotifierProvider<CourseArchitectWorkflowNotifier, CourseArchitectWorkflowModel>((ref) {
  return CourseArchitectWorkflowNotifier()..loadData();
});
