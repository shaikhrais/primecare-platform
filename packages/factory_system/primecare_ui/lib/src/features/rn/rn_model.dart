import 'package:primecare_ui/src/shared/primecare_adapters.dart';

class RnViewModel extends PrimeCareDashboardViewModel {
  const RnViewModel({
    required super.metrics,
    required super.insights,
    super.isOfflineFallback = false,
  });

  factory RnViewModel.empty() {
    return RnViewModel(
      metrics: DashboardMetrics.empty(),
      insights: const [],
    );
  }
}
