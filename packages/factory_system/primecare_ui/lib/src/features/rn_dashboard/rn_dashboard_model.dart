import 'package:primecare_ui/src/shared/primecare_adapters.dart';

class RnDashboardViewModel extends PrimeCareDashboardViewModel {
  const RnDashboardViewModel({
    required super.metrics,
    required super.insights,
    super.isOfflineFallback = false,
  });

  factory RnDashboardViewModel.empty() {
    return RnDashboardViewModel(
      metrics: DashboardMetrics.empty(),
      insights: const [],
    );
  }
}
