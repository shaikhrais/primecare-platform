import 'package:primecare_ui/src/shared/primecare_adapters.dart';

class IntakeCoordinatorDashboardViewModel extends PrimeCareDashboardViewModel {
  const IntakeCoordinatorDashboardViewModel({
    required super.metrics,
    required super.insights,
    super.isOfflineFallback = false,
  });

  factory IntakeCoordinatorDashboardViewModel.empty() {
    return IntakeCoordinatorDashboardViewModel(
      metrics: DashboardMetrics.empty(),
      insights: const [],
    );
  }
}
