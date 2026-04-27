import 'package:primecare_ui/src/shared/primecare_adapters.dart';

class PswViewModel extends PrimeCareDashboardViewModel {
  const PswViewModel({
    required super.metrics,
    required super.insights,
    super.isOfflineFallback = false,
  });

  factory PswViewModel.empty() {
    return PswViewModel(
      metrics: DashboardMetrics.empty(),
      insights: const [],
    );
  }
}
