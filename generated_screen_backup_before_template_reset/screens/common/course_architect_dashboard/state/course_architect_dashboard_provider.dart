import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/course_architect_dashboard_model.dart';

class CourseArchitectDashboardNotifier extends StateNotifier<CourseArchitectDashboardModel> {
  CourseArchitectDashboardNotifier() : super(const CourseArchitectDashboardModel(isLoading: true));

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

final course_architect_dashboardProvider = StateNotifierProvider<CourseArchitectDashboardNotifier, CourseArchitectDashboardModel>((ref) {
  return CourseArchitectDashboardNotifier()..loadData();
});
