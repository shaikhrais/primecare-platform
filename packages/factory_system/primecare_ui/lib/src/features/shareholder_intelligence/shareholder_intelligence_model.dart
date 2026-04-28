import 'package:primecare_ui/src/shared/primecare_adapters.dart';

class ShareholderIntelligenceViewModel extends PrimeCareDashboardViewModel {
  const ShareholderIntelligenceViewModel({
    required super.metrics,
    required super.insights,
    super.isOfflineFallback = false,
  });

  factory ShareholderIntelligenceViewModel.empty() {
    return ShareholderIntelligenceViewModel(
      metrics: DashboardMetrics.empty(),
      insights: const [],
    );
  }
}
