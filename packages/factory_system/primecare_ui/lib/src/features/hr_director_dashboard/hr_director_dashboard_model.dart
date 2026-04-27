import 'package:primecare_ui/src/shared/primecare_adapters.dart';

class HumanResourcesDirectorDashboardViewModel extends PrimeCareDashboardViewModel {
  const HumanResourcesDirectorDashboardViewModel({
    required super.metrics,
    required super.insights,
    super.isOfflineFallback = false,
  });

  factory HumanResourcesDirectorDashboardViewModel.empty() {
    return HumanResourcesDirectorDashboardViewModel(
      metrics: DashboardMetrics.empty(),
      insights: const [],
    );
  }
}
