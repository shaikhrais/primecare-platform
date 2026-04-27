import 'package:primecare_ui/src/shared/primecare_adapters.dart';

class VolunteerCoordinatorDashboardViewModel extends PrimeCareDashboardViewModel {
  const VolunteerCoordinatorDashboardViewModel({
    required super.metrics,
    required super.insights,
    super.isOfflineFallback = false,
  });

  factory VolunteerCoordinatorDashboardViewModel.empty() {
    return VolunteerCoordinatorDashboardViewModel(
      metrics: DashboardMetrics.empty(),
      insights: const [],
    );
  }
}
