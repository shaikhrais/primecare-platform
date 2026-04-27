import 'package:primecare_ui/src/shared/primecare_adapters.dart';

class FranchiseSalesManagerDashboardViewModel extends PrimeCareDashboardViewModel {
  const FranchiseSalesManagerDashboardViewModel({
    required super.metrics,
    required super.insights,
    super.isOfflineFallback = false,
  });

  factory FranchiseSalesManagerDashboardViewModel.empty() {
    return FranchiseSalesManagerDashboardViewModel(
      metrics: DashboardMetrics.empty(),
      insights: const [],
    );
  }
}
