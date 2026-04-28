import 'package:primecare_ui/src/shared/primecare_adapters.dart';

class CommunityOutreachDashboardViewModel extends PrimeCareDashboardViewModel {
  const CommunityOutreachDashboardViewModel({
    required super.metrics,
    required super.insights,
  });

  factory CommunityOutreachDashboardViewModel.empty() {
    return CommunityOutreachDashboardViewModel(
      metrics: DashboardMetrics.empty(),
      insights: const [],
    );
  }
}
