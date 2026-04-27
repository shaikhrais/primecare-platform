import 'package:primecare_ui/src/shared/primecare_adapters.dart';

class RpnViewModel extends PrimeCareDashboardViewModel {
  const RpnViewModel({
    required super.metrics,
    required super.insights,
    super.isOfflineFallback = false,
  });

  factory RpnViewModel.empty() {
    return RpnViewModel(
      metrics: DashboardMetrics.empty(),
      insights: const [],
    );
  }
}
