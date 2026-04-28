import 'package:primecare_ui/src/shared/primecare_adapters.dart';

class FamilyDashboardViewModel extends PrimeCareDashboardViewModel {
  const FamilyDashboardViewModel({
    required super.metrics,
    required super.insights,
  });

  factory FamilyDashboardViewModel.empty() {
    return FamilyDashboardViewModel(
      metrics: DashboardMetrics.empty(),
      insights: const [],
    );
  }
}
