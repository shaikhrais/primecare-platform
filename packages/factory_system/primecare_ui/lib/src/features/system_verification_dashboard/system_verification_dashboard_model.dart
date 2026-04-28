import 'package:primecare_ui/src/shared/primecare_adapters.dart';

class SystemVerificationDashboardViewModel extends PrimeCareDashboardViewModel {
  const SystemVerificationDashboardViewModel({
    required super.metrics,
    required super.insights,
    super.isOfflineFallback = false,
  });

  factory SystemVerificationDashboardViewModel.empty() {
    return SystemVerificationDashboardViewModel(
      metrics: DashboardMetrics.empty(),
      insights: const [],
    );
  }
}
