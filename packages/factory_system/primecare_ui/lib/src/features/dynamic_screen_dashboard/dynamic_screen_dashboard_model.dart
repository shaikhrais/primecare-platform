import 'package:primecare_ui/src/shared/primecare_adapters.dart';

class DynamicScreenDashboardViewModel extends PrimeCareDashboardViewModel {
  const DynamicScreenDashboardViewModel({
    required super.metrics,
    required super.insights,
  });

  factory DynamicScreenDashboardViewModel.empty() {
    return DynamicScreenDashboardViewModel(
      metrics: DashboardMetrics.empty(),
      insights: const [],
    );
  }
}
