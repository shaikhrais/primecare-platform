import 'package:primecare_ui/src/shared/primecare_adapters.dart';

class RegionalBdmDashboardViewModel extends PrimeCareDashboardViewModel {
  const RegionalBdmDashboardViewModel({
    required super.metrics,
    required super.insights,
    super.isOfflineFallback = false,
  });

  factory RegionalBdmDashboardViewModel.empty() {
    return RegionalBdmDashboardViewModel(
      metrics: DashboardMetrics.empty(),
      insights: const [],
    );
  }
}
