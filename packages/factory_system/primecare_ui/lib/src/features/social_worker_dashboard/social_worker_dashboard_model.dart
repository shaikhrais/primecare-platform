import 'package:primecare_ui/src/shared/primecare_adapters.dart';

class SocialWorkerDashboardViewModel extends PrimeCareDashboardViewModel {
  const SocialWorkerDashboardViewModel({
    required super.metrics,
    required super.insights,
    super.isOfflineFallback = false,
  });

  factory SocialWorkerDashboardViewModel.empty() {
    return SocialWorkerDashboardViewModel(
      metrics: DashboardMetrics.empty(),
      insights: const [],
    );
  }
}
