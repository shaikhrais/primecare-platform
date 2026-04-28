import 'package:primecare_ui/src/shared/primecare_adapters.dart';

class IntakeDashboardViewModel extends PrimeCareDashboardViewModel {
  const IntakeDashboardViewModel({
    required super.metrics,
    required super.insights,
    super.isOfflineFallback = false,
  });

  factory IntakeDashboardViewModel.empty() {
    return IntakeDashboardViewModel(
      metrics: DashboardMetrics.empty(),
      insights: const [],
    );
  }
}
