import 'package:primecare_ui/src/shared/primecare_adapters.dart';

class SchedulerDashboardViewModel extends PrimeCareDashboardViewModel {
  const SchedulerDashboardViewModel({
    required super.metrics,
    required super.insights,
    super.isOfflineFallback = false,
  });

  factory SchedulerDashboardViewModel.empty() {
    return SchedulerDashboardViewModel(
      metrics: DashboardMetrics.empty(),
      insights: const [],
    );
  }
}
