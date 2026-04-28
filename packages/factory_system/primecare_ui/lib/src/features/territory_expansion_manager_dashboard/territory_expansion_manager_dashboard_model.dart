import 'package:primecare_ui/src/shared/primecare_adapters.dart';

class TerritoryExpansionManagerDashboardViewModel
    extends PrimeCareDashboardViewModel {
  const TerritoryExpansionManagerDashboardViewModel({
    required super.metrics,
    required super.insights,
    super.isOfflineFallback = false,
  });

  factory TerritoryExpansionManagerDashboardViewModel.empty() {
    return TerritoryExpansionManagerDashboardViewModel(
      metrics: DashboardMetrics.empty(),
      insights: const [],
    );
  }
}
