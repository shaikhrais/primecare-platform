import 'package:primecare_ui/src/shared/primecare_adapters.dart';

class DynamicRoleDashboardScreenViewModel extends PrimeCareDashboardViewModel {
  const DynamicRoleDashboardScreenViewModel({
    required super.metrics,
    required super.insights,
  });

  factory DynamicRoleDashboardScreenViewModel.empty() {
    return DynamicRoleDashboardScreenViewModel(
      metrics: DashboardMetrics.empty(),
      insights: const [],
    );
  }
}
