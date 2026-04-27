import 'package:primecare_ui/src/shared/primecare_adapters.dart';

class OwnerDashboardViewModel extends PrimeCareDashboardViewModel {
  const OwnerDashboardViewModel({
    required super.metrics,
    required super.insights,
    super.isOfflineFallback = false,
  });

  factory OwnerDashboardViewModel.empty() {
    return OwnerDashboardViewModel(
      metrics: DashboardMetrics.empty(),
      insights: const [],
    );
  }
}
