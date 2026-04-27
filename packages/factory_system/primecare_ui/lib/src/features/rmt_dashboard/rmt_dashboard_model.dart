import 'package:primecare_ui/src/shared/primecare_adapters.dart';

class RmtDashboardViewModel extends PrimeCareDashboardViewModel {
  const RmtDashboardViewModel({
    required super.metrics,
    required super.insights,
    super.isOfflineFallback = false,
  });

  factory RmtDashboardViewModel.empty() {
    return RmtDashboardViewModel(
      metrics: DashboardMetrics.empty(),
      insights: const [],
    );
  }
}
