import 'package:primecare_ui/src/shared/primecare_adapters.dart';

class QaDashboardViewModel extends PrimeCareDashboardViewModel {
  const QaDashboardViewModel({
    required super.metrics,
    required super.insights,
    super.isOfflineFallback = false,
  });

  factory QaDashboardViewModel.empty() {
    return QaDashboardViewModel(
      metrics: DashboardMetrics.empty(),
      insights: const [],
    );
  }
}
