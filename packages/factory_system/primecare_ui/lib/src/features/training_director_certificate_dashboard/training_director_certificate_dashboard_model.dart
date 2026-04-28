import 'package:primecare_ui/src/shared/primecare_adapters.dart';

class TrainingDirectorCertificateDashboardViewModel
    extends PrimeCareDashboardViewModel {
  const TrainingDirectorCertificateDashboardViewModel({
    required super.metrics,
    required super.insights,
    super.isOfflineFallback = false,
  });

  factory TrainingDirectorCertificateDashboardViewModel.empty() {
    return TrainingDirectorCertificateDashboardViewModel(
      metrics: DashboardMetrics.empty(),
      insights: const [],
    );
  }
}
