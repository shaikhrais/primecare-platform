import 'package:primecare_ui/src/shared/primecare_adapters.dart';

class CourseArchitectDashboardViewModel extends PrimeCareDashboardViewModel {
  const CourseArchitectDashboardViewModel({
    required super.metrics,
    required super.insights,
  });

  factory CourseArchitectDashboardViewModel.empty() {
    return CourseArchitectDashboardViewModel(
      metrics: DashboardMetrics.empty(),
      insights: const [],
    );
  }
}
