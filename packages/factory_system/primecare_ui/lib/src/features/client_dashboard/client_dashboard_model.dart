import 'package:primecare_ui/src/shared/primecare_adapters.dart';

class ClientDashboardViewModel extends PrimeCareDashboardViewModel {
  const ClientDashboardViewModel({
    required super.metrics,
    required super.insights,
  });

  factory ClientDashboardViewModel.empty() {
    return ClientDashboardViewModel(
      metrics: DashboardMetrics.empty(),
      insights: const [],
    );
  }
}
