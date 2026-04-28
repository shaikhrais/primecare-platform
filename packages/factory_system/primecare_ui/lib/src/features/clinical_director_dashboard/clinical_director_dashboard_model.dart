import 'package:primecare_ui/src/shared/primecare_adapters.dart';

class ClinicalDirectorDashboardViewModel extends PrimeCareDashboardViewModel {
  const ClinicalDirectorDashboardViewModel({
    required super.metrics,
    required super.insights,
    super.isOfflineFallback = false,
  });

  factory ClinicalDirectorDashboardViewModel.empty() {
    return ClinicalDirectorDashboardViewModel(
      metrics: DashboardMetrics.empty(),
      insights: const [],
    );
  }
}
