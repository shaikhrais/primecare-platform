import 'package:primecare_ui/src/shared/primecare_adapters.dart';

class FranchiseOwnerDashboardViewModel extends PrimeCareDashboardViewModel {
  const FranchiseOwnerDashboardViewModel({
    required super.metrics,
    required super.insights,
    super.isOfflineFallback = false,
  });

  factory FranchiseOwnerDashboardViewModel.empty() {
    return FranchiseOwnerDashboardViewModel(
      metrics: DashboardMetrics.empty(),
      insights: const [],
    );
  }
}
