import 'package:primecare_ui/src/shared/primecare_adapters.dart';

class CXDirectorDashboardViewModel extends PrimeCareDashboardViewModel {
  const CXDirectorDashboardViewModel({
    required super.metrics,
    required super.insights,
    super.isOfflineFallback = false,
  });

  factory CXDirectorDashboardViewModel.empty() {
    return CXDirectorDashboardViewModel(
      metrics: DashboardMetrics.empty(),
      insights: const [],
    );
  }
}
