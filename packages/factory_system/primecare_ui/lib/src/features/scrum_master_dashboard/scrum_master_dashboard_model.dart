import 'package:primecare_ui/src/shared/primecare_adapters.dart';

class ScrumMasterDashboardViewModel extends PrimeCareDashboardViewModel {
  const ScrumMasterDashboardViewModel({
    required super.metrics,
    required super.insights,
    super.isOfflineFallback = false,
  });

  factory ScrumMasterDashboardViewModel.empty() {
    return ScrumMasterDashboardViewModel(
      metrics: DashboardMetrics.empty(),
      insights: const [],
    );
  }
}
