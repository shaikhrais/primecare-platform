import 'package:primecare_ui/src/shared/primecare_adapters.dart';

class TrainingCoordinatorDashboardViewModel
    extends PrimeCareDashboardViewModel {
  const TrainingCoordinatorDashboardViewModel({
    required super.metrics,
    required super.insights,
    super.isOfflineFallback = false,
  });

  factory TrainingCoordinatorDashboardViewModel.empty() {
    return TrainingCoordinatorDashboardViewModel(
      metrics: DashboardMetrics.empty(),
      insights: const [],
    );
  }
}
