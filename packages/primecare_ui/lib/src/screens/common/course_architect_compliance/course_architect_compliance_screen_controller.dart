import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CourseArchitectComplianceScreenState {
  final bool isLoading;
  final String? error;
  final Map<String, dynamic> data;

  CourseArchitectComplianceScreenState({required this.isLoading, this.error, required this.data});

  CourseArchitectComplianceScreenState copyWith({bool? isLoading, String? error, Map<String, dynamic>? data}) {
    return CourseArchitectComplianceScreenState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      data: data ?? this.data,
    );
  }
}

class CourseArchitectComplianceScreenController extends StateNotifier<CourseArchitectComplianceScreenState> {
  final Ref ref;
  CourseArchitectComplianceScreenController(this.ref) : super(CourseArchitectComplianceScreenState(isLoading: true, data: {})) {
    loadDashboardData();
  }

  Future<void> loadDashboardData() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final response = await ref.read(apiClientProvider).get('/common/course-architect-compliance');
      if (response.isSuccess) {
        state = state.copyWith(
          isLoading: false,
          data: response.data is Map ? Map<String, dynamic>.from(response.data) : {},
        );
      } else {
        state = state.copyWith(
          isLoading: false,
          error: response.error ?? 'Failed to load live data',
        );
      }
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Future<void> syncData() async {
    await loadDashboardData();
  }
}

final course_architect_complianceControllerProvider = StateNotifierProvider<CourseArchitectComplianceScreenController, CourseArchitectComplianceScreenState>((ref) {
  return CourseArchitectComplianceScreenController(ref);
});
