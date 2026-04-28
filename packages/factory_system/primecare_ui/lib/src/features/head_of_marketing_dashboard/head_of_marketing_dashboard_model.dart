import 'package:primecare_ui/src/shared/primecare_adapters.dart';

class HeadOfMarketingDashboardViewModel extends PrimeCareDashboardViewModel {
  const HeadOfMarketingDashboardViewModel({
    required super.metrics,
    required super.insights,
    super.isOfflineFallback = false,
  });

  factory HeadOfMarketingDashboardViewModel.empty() {
    return HeadOfMarketingDashboardViewModel(
      metrics: DashboardMetrics.empty(),
      insights: const [],
    );
  }
}
