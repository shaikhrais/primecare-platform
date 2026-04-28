import 'package:primecare_ui/src/shared/primecare_adapters.dart';

class ITSecurityDashboardViewModel extends PrimeCareDashboardViewModel {
  const ITSecurityDashboardViewModel({
    required super.metrics,
    required super.insights,
    super.isOfflineFallback = false,
  });

  factory ITSecurityDashboardViewModel.empty() {
    return ITSecurityDashboardViewModel(
      metrics: DashboardMetrics.empty(),
      insights: const [],
    );
  }
}
