import 'package:primecare_ui/src/shared/primecare_adapters.dart';

class SupportDashboardViewModel extends PrimeCareDashboardViewModel {
  const SupportDashboardViewModel({
    required super.metrics,
    required super.insights,
    super.isOfflineFallback = false,
  });

  factory SupportDashboardViewModel.empty() {
    return SupportDashboardViewModel(
      metrics: DashboardMetrics.empty(),
      insights: const [],
    );
  }
}
