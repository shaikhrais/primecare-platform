import 'package:primecare_ui/src/shared/primecare_adapters.dart';

class RegionalManagerDashboardViewModel extends PrimeCareDashboardViewModel {
  const RegionalManagerDashboardViewModel({
    required super.metrics,
    required super.insights,
    super.isOfflineFallback = false,
  });

  factory RegionalManagerDashboardViewModel.empty() {
    return RegionalManagerDashboardViewModel(
      metrics: DashboardMetrics.empty(),
      insights: const [],
    );
  }
}
