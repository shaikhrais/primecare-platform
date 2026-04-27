import 'package:primecare_ui/src/shared/primecare_adapters.dart';

class OperationsManagerDashboardViewModel extends PrimeCareDashboardViewModel {
  const OperationsManagerDashboardViewModel({
    required super.metrics,
    required super.insights,
    super.isOfflineFallback = false,
  });

  factory OperationsManagerDashboardViewModel.empty() {
    return OperationsManagerDashboardViewModel(
      metrics: DashboardMetrics.empty(),
      insights: const [],
    );
  }
}
