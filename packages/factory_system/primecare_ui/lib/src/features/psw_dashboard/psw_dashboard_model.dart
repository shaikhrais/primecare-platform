import 'package:primecare_ui/src/shared/primecare_adapters.dart';

class PswDashboardViewModel extends PrimeCareDashboardViewModel {
  const PswDashboardViewModel({
    required super.metrics,
    required super.insights,
    super.isOfflineFallback = false,
  });

  factory PswDashboardViewModel.empty() {
    return PswDashboardViewModel(
      metrics: DashboardMetrics.empty(),
      insights: const [],
    );
  }
}
