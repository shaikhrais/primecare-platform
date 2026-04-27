import 'package:primecare_ui/src/shared/primecare_adapters.dart';

class TerritorySalesManagerDashboardViewModel extends PrimeCareDashboardViewModel {
  const TerritorySalesManagerDashboardViewModel({
    required super.metrics,
    required super.insights,
    super.isOfflineFallback = false,
  });

  factory TerritorySalesManagerDashboardViewModel.empty() {
    return TerritorySalesManagerDashboardViewModel(
      metrics: DashboardMetrics.empty(),
      insights: const [],
    );
  }
}
