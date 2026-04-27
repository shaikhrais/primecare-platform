import 'package:primecare_ui/src/shared/primecare_adapters.dart';

class GeneralManagerDashboardViewModel extends PrimeCareDashboardViewModel {
  const GeneralManagerDashboardViewModel({
    required super.metrics,
    required super.insights,
    super.isOfflineFallback = false,
  });

  factory GeneralManagerDashboardViewModel.empty() {
    return GeneralManagerDashboardViewModel(
      metrics: DashboardMetrics.empty(),
      insights: const [],
    );
  }
}
