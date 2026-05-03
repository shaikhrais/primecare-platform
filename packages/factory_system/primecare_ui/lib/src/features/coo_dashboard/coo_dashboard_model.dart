import 'package:primecare_ui/src/shared/primecare_adapters.dart';

class COODashboardViewModel extends PrimeCareDashboardViewModel {
  const COODashboardViewModel({
    required super.metrics,
    required super.insights,
    super.isOfflineFallback = false,
  });

  factory COODashboardViewModel.empty() {
    return COODashboardViewModel(
      metrics: DashboardMetrics.empty(),
      insights: const [],
    );
  }
}
