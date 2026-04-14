import '../../../common/domain/models/primecare_dashboard_view_model.dart';
import '../../../../dashboard_service.dart';

class IntakeCoordinatorDashboardViewModel extends PrimeCareDashboardViewModel {
  const IntakeCoordinatorDashboardViewModel({
    super.isOfflineFallback = false,
    super.kpis = const [],
    super.recentActivity = const [],
    super.blueprints = const [],
  });

  factory IntakeCoordinatorDashboardViewModel.fromJson(Map<String, dynamic> json) {
    final base = PrimeCareDashboardViewModel.fromJson(json);
    return IntakeCoordinatorDashboardViewModel(
      isOfflineFallback: base.isOfflineFallback,
      kpis: base.kpis,
      recentActivity: base.recentActivity,
      blueprints: base.blueprints,
    );
  }

  factory IntakeCoordinatorDashboardViewModel.fromDashboardMetrics(
    DashboardMetrics metrics,
  ) {
    final base = PrimeCareDashboardViewModel.fromDashboardMetrics(metrics);
    return IntakeCoordinatorDashboardViewModel(
      isOfflineFallback: base.isOfflineFallback,
      kpis: base.kpis,
      recentActivity: base.recentActivity,
      blueprints: base.blueprints,
    );
  }

  factory IntakeCoordinatorDashboardViewModel.assemble({required bool isOffline}) {
    final base = PrimeCareDashboardViewModel.assemble(isOffline: isOffline);
    return IntakeCoordinatorDashboardViewModel(
      isOfflineFallback: base.isOfflineFallback,
      kpis: base.kpis,
      recentActivity: base.recentActivity,
      blueprints: base.blueprints,
    );
  }
}
