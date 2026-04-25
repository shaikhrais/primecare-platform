import 'package:primecare_adapters/primecare_adapters.dart';

class FamilyMemberDashboardViewModel extends PrimeCareDashboardViewModel {
  const FamilyMemberDashboardViewModel({
    required super.metrics,
    required super.insights,
    super.blueprints,
    super.isOfflineFallback,
  });

  factory FamilyMemberDashboardViewModel.empty({
    bool isOfflineFallback = false,
  }) => FamilyMemberDashboardViewModel(
    metrics: DashboardMetrics.empty(),
    insights: const [],
    isOfflineFallback: isOfflineFallback,
  );

  factory FamilyMemberDashboardViewModel.fromDashboardMetrics(
    DashboardMetrics metrics,
  ) {
    return FamilyMemberDashboardViewModel(metrics: metrics, insights: const []);
  }

  factory FamilyMemberDashboardViewModel.fromJson(Map<String, dynamic> json) {
    final base = PrimeCareDashboardViewModel.fromJson(json);
    return FamilyMemberDashboardViewModel(
      metrics: base.metrics,
      insights: base.insights,
      blueprints: base.blueprints,
      isOfflineFallback: base.isOfflineFallback,
    );
  }
}
