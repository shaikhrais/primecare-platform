import 'package:primecare_ui/src/shared/primecare_adapters.dart';

class HrHiringDashboardViewModel extends PrimeCareDashboardViewModel {
  const HrHiringDashboardViewModel({
    required super.metrics,
    required super.insights,
    super.isOfflineFallback = false,
  });

  factory HrHiringDashboardViewModel.empty() {
    return HrHiringDashboardViewModel(
      metrics: DashboardMetrics.empty(),
      insights: const [],
    );
  }
}
