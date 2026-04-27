import 'package:primecare_ui/src/shared/primecare_adapters.dart';

class HeadOfBusDevDashboardViewModel extends PrimeCareDashboardViewModel {
  const HeadOfBusDevDashboardViewModel({
    required super.metrics,
    required super.insights,
    super.isOfflineFallback = false,
  });

  factory HeadOfBusDevDashboardViewModel.empty() {
    return HeadOfBusDevDashboardViewModel(
      metrics: DashboardMetrics.empty(),
      insights: const [],
    );
  }
}
