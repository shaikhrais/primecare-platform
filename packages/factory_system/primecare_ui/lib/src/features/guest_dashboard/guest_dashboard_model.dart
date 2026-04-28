import 'package:primecare_ui/src/shared/primecare_adapters.dart';

class GuestDashboardViewModel extends PrimeCareDashboardViewModel {
  const GuestDashboardViewModel({
    required super.metrics,
    required super.insights,
    super.isOfflineFallback = false,
  });

  factory GuestDashboardViewModel.empty() {
    return GuestDashboardViewModel(
      metrics: DashboardMetrics.empty(),
      insights: const [],
    );
  }
}
