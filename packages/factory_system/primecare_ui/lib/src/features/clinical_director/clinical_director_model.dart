import 'package:primecare_ui/src/shared/primecare_adapters.dart';

class ClinicalDirectorViewModel extends PrimeCareDashboardViewModel {
  const ClinicalDirectorViewModel({
    required super.metrics,
    required super.insights,
    super.isOfflineFallback = false,
  });

  factory ClinicalDirectorViewModel.empty() {
    return ClinicalDirectorViewModel(
      metrics: DashboardMetrics.empty(),
      insights: const [],
    );
  }
}
