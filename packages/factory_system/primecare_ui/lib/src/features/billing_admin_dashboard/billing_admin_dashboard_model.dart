import 'package:primecare_ui/src/shared/primecare_adapters.dart';

class BillingAdminDashboardViewModel extends PrimeCareDashboardViewModel {
  const BillingAdminDashboardViewModel({
    required super.metrics,
    required super.insights,
    super.isOfflineFallback = false,
  });

  factory BillingAdminDashboardViewModel.empty() {
    return BillingAdminDashboardViewModel(
      metrics: DashboardMetrics.empty(),
      insights: const [],
    );
  }
}
