import 'package:primecare_ui/src/shared/primecare_adapters.dart';

class PartnershipManagerDashboardViewModel extends PrimeCareDashboardViewModel {
  const PartnershipManagerDashboardViewModel({
    required super.metrics,
    required super.insights,
    super.isOfflineFallback = false,
  });

  factory PartnershipManagerDashboardViewModel.empty() {
    return PartnershipManagerDashboardViewModel(
      metrics: DashboardMetrics.empty(),
      insights: const [],
    );
  }
}
