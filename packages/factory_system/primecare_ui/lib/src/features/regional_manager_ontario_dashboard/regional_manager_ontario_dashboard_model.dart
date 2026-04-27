import 'package:primecare_ui/src/shared/primecare_adapters.dart';

class RegionalManagerOntarioDashboardViewModel extends PrimeCareDashboardViewModel {
  const RegionalManagerOntarioDashboardViewModel({
    required super.metrics,
    required super.insights,
    super.isOfflineFallback = false,
  });

  factory RegionalManagerOntarioDashboardViewModel.empty() {
    return RegionalManagerOntarioDashboardViewModel(
      metrics: DashboardMetrics.empty(),
      insights: const [],
    );
  }
}
