import 'package:primecare_ui/src/shared/primecare_adapters.dart';

class TrainingDirectorDashboardViewModel extends PrimeCareDashboardViewModel {
  const TrainingDirectorDashboardViewModel({
    required super.metrics,
    required super.insights,
    super.isOfflineFallback = false,
  });

  factory TrainingDirectorDashboardViewModel.empty() {
    return TrainingDirectorDashboardViewModel(
      metrics: DashboardMetrics.empty(),
      insights: const [],
    );
  }
}
