import 'package:primecare_ui/src/shared/primecare_adapters.dart';

class ReceptionistDashboardViewModel extends PrimeCareDashboardViewModel {
  const ReceptionistDashboardViewModel({
    required super.metrics,
    required super.insights,
    super.isOfflineFallback = false,
  });

  factory ReceptionistDashboardViewModel.empty() {
    return ReceptionistDashboardViewModel(
      metrics: DashboardMetrics.empty(),
      insights: const [],
    );
  }
}
