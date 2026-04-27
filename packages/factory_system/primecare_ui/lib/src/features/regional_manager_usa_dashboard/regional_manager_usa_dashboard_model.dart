import 'package:primecare_ui/src/shared/primecare_adapters.dart';

class RegionalManagerUsaDashboardViewModel extends PrimeCareDashboardViewModel {
  const RegionalManagerUsaDashboardViewModel({
    required super.metrics,
    required super.insights,
    super.isOfflineFallback = false,
  });

  factory RegionalManagerUsaDashboardViewModel.empty() {
    return RegionalManagerUsaDashboardViewModel(
      metrics: DashboardMetrics.empty(),
      insights: const [],
    );
  }
}
