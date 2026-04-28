import 'package:primecare_ui/src/shared/primecare_adapters.dart';

class FinanceDirectorDashboardViewModel extends PrimeCareDashboardViewModel {
  const FinanceDirectorDashboardViewModel({
    required super.metrics,
    required super.insights,
    super.isOfflineFallback = false,
  });

  factory FinanceDirectorDashboardViewModel.empty() {
    return FinanceDirectorDashboardViewModel(
      metrics: DashboardMetrics.empty(),
      insights: const [],
    );
  }
}
