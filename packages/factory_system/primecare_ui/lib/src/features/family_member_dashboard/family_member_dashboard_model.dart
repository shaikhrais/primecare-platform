import 'package:primecare_ui/src/shared/primecare_adapters.dart';

class FamilyMemberDashboardViewModel extends PrimeCareDashboardViewModel {
  const FamilyMemberDashboardViewModel({
    required super.metrics,
    required super.insights,
  });

  factory FamilyMemberDashboardViewModel.empty() {
    return FamilyMemberDashboardViewModel(
      metrics: DashboardMetrics.empty(),
      insights: const [],
    );
  }
}
