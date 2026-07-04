import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/course_architect_compliance_model.dart';

class CourseArchitectComplianceNotifier extends StateNotifier<CourseArchitectComplianceModel> {
  CourseArchitectComplianceNotifier() : super(const CourseArchitectComplianceModel(isLoading: true));

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

final course_architect_complianceProvider = StateNotifierProvider<CourseArchitectComplianceNotifier, CourseArchitectComplianceModel>((ref) {
  return CourseArchitectComplianceNotifier()..loadData();
});
