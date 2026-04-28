import 'package:primecare_ui/src/shared/primecare_adapters.dart';

class MarketingManagerDashboardViewModel extends PrimeCareDashboardViewModel {
  const MarketingManagerDashboardViewModel({
    required super.metrics,
    required super.insights,
    super.isOfflineFallback = false,
  });

  factory MarketingManagerDashboardViewModel.empty() {
    return MarketingManagerDashboardViewModel(
      metrics: DashboardMetrics.empty(),
      insights: const [],
    );
  }
}
