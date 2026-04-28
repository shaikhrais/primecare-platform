import 'package:primecare_ui/src/shared/primecare_adapters.dart';

class LocalMarketingManagerDashboardViewModel
    extends PrimeCareDashboardViewModel {
  const LocalMarketingManagerDashboardViewModel({
    required super.metrics,
    required super.insights,
    super.isOfflineFallback = false,
  });

  factory LocalMarketingManagerDashboardViewModel.empty() {
    return LocalMarketingManagerDashboardViewModel(
      metrics: DashboardMetrics.empty(),
      insights: const [],
    );
  }
}
