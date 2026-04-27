import 'package:primecare_ui/src/shared/primecare_adapters.dart';

class CorporateGovernanceDashboardViewModel extends PrimeCareDashboardViewModel {
  const CorporateGovernanceDashboardViewModel({
    required super.metrics,
    required super.insights,
    super.isOfflineFallback = false,
  });

  factory CorporateGovernanceDashboardViewModel.empty() {
    return CorporateGovernanceDashboardViewModel(
      metrics: DashboardMetrics.empty(),
      insights: const [],
    );
  }
}
