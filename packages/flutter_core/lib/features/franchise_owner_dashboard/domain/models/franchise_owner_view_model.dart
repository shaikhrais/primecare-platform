import '../../../common/domain/models/primecare_dashboard_view_model.dart';
import '../../../../dashboard_service.dart';

class FranchiseOwnerViewModel extends PrimeCareDashboardViewModel {
  const FranchiseOwnerViewModel({
    super.isOfflineFallback = false,
    super.kpis = const [],
    super.recentActivity = const [],
    super.blueprints = const [],
  });

  factory FranchiseOwnerViewModel.fromJson(Map<String, dynamic> json) {
    final base = PrimeCareDashboardViewModel.fromJson(json);
    return FranchiseOwnerViewModel(
      isOfflineFallback: base.isOfflineFallback,
      kpis: base.kpis,
      recentActivity: base.recentActivity,
      blueprints: base.blueprints,
    );
  }

  factory FranchiseOwnerViewModel.fromDashboardMetrics(
    DashboardMetrics metrics,
  ) {
    final base = PrimeCareDashboardViewModel.fromDashboardMetrics(metrics);
    return FranchiseOwnerViewModel(
      isOfflineFallback: base.isOfflineFallback,
      kpis: base.kpis,
      recentActivity: base.recentActivity,
      blueprints: base.blueprints,
    );
  }

  factory FranchiseOwnerViewModel.assemble({required bool isOffline}) {
    final base = PrimeCareDashboardViewModel.assemble(isOffline: isOffline);
    return FranchiseOwnerViewModel(
      isOfflineFallback: base.isOfflineFallback,
      kpis: base.kpis,
      recentActivity: base.recentActivity,
      blueprints: base.blueprints,
    );
  }
}
