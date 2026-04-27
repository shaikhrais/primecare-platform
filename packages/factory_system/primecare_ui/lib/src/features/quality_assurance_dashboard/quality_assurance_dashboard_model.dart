import 'package:primecare_ui/src/shared/primecare_adapters.dart';

class QualityAssuranceDashboardViewModel extends PrimeCareDashboardViewModel {
  const QualityAssuranceDashboardViewModel({
    required super.metrics,
    required super.insights,
    super.isOfflineFallback = false,
  });

  factory QualityAssuranceDashboardViewModel.empty() {
    return QualityAssuranceDashboardViewModel(
      metrics: DashboardMetrics.empty(),
      insights: const [],
    );
  }
}
