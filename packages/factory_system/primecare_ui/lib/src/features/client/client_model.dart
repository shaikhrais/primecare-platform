import 'package:primecare_ui/src/shared/primecare_adapters.dart';

class ClientViewModel extends PrimeCareDashboardViewModel {
  const ClientViewModel({
    required super.metrics,
    required super.insights,
    super.isOfflineFallback = false,
  });

  factory ClientViewModel.empty() {
    return ClientViewModel(
      metrics: DashboardMetrics.empty(),
      insights: const [],
    );
  }
}
