import 'package:primecare_ui/src/shared/primecare_adapters.dart';

class IntakeCoordinatorViewModel extends PrimeCareDashboardViewModel {
  const IntakeCoordinatorViewModel({
    required super.metrics,
    required super.insights,
    super.isOfflineFallback = false,
  });

  factory IntakeCoordinatorViewModel.empty() {
    return IntakeCoordinatorViewModel(
      metrics: DashboardMetrics.empty(),
      insights: const [],
    );
  }
}
