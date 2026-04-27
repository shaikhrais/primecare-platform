import 'package:primecare_ui/src/shared/primecare_adapters.dart';
import 'course_architect_dashboard_model.dart';

final courseArchitectAdapterProvider = StateNotifierProvider<CourseArchitectDashboardController, AsyncValue<Result<CourseArchitectDashboardViewModel>>>((ref) {
  return CourseArchitectDashboardController(ref);
});

class CourseArchitectDashboardController extends StateNotifier<AsyncValue<Result<CourseArchitectDashboardViewModel>>> {
  final Ref ref;
  
  CourseArchitectDashboardController(this.ref) : super(const AsyncValue.loading()) {
    refresh();
  }
  
  Future<void> refresh() async {
    state = const AsyncValue.loading();
    final service = ref.read(dashboardServiceProvider);
    
    try {
      final result = await service.getMetrics('course_architect');
      state = AsyncValue.data(result.map((metrics) => CourseArchitectDashboardViewModel(
        metrics: metrics,
        insights: const [],
      )));
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}
