import 'package:primecare_ui/src/shared/primecare_adapters.dart';

class HumanResourcesManagerDashboardViewModel extends PrimeCareDashboardViewModel {
  const HumanResourcesManagerDashboardViewModel({
    required super.metrics,
    required super.insights,
    super.isOfflineFallback = false,
  });

  factory HumanResourcesManagerDashboardViewModel.empty() {
    return HumanResourcesManagerDashboardViewModel(
      metrics: DashboardMetrics.empty(),
      insights: const [],
    );
  }
}
