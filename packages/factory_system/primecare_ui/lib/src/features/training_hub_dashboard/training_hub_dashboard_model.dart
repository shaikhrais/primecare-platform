import 'package:primecare_ui/src/shared/primecare_adapters.dart';

class TrainingHubDashboardViewModel extends PrimeCareDashboardViewModel {
  const TrainingHubDashboardViewModel({
    required super.metrics,
    required super.insights,
    super.isOfflineFallback = false,
  });

  factory TrainingHubDashboardViewModel.empty() {
    return TrainingHubDashboardViewModel(
      metrics: DashboardMetrics.empty(),
      insights: const [],
    );
  }
}
