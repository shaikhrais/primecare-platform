import 'package:primecare_ui/src/shared/primecare_adapters.dart';

class InfectionControlDashboardViewModel extends PrimeCareDashboardViewModel {
  const InfectionControlDashboardViewModel({
    required super.metrics,
    required super.insights,
    super.isOfflineFallback = false,
  });

  factory InfectionControlDashboardViewModel.empty() {
    return InfectionControlDashboardViewModel(
      metrics: DashboardMetrics.empty(),
      insights: const [],
    );
  }
}
