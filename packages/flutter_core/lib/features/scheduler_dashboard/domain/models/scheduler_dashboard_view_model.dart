import '../../../common/domain/models/primecare_dashboard_view_model.dart';
import '../../../../dashboard_service.dart';

class SchedulerCoordinatorDashboardViewModel
    extends PrimeCareDashboardViewModel {
  const SchedulerCoordinatorDashboardViewModel({
    super.isOfflineFallback = false,
    super.kpis = const [],
    super.recentActivity = const [],
    super.blueprints = const [],
  });

  factory SchedulerCoordinatorDashboardViewModel.fromJson(
    Map<String, dynamic> json,
  ) {
    final base = PrimeCareDashboardViewModel.fromJson(json);
    return SchedulerCoordinatorDashboardViewModel(
      isOfflineFallback: base.isOfflineFallback,
      kpis: base.kpis,
      recentActivity: base.recentActivity,
      blueprints: base.blueprints,
    );
  }

  factory SchedulerCoordinatorDashboardViewModel.fromDashboardMetrics(
    DashboardMetrics metrics,
  ) {
    final base = PrimeCareDashboardViewModel.fromDashboardMetrics(metrics);
    return SchedulerCoordinatorDashboardViewModel(
      isOfflineFallback: base.isOfflineFallback,
      kpis: base.kpis,
      recentActivity: base.recentActivity,
      blueprints: base.blueprints,
    );
  }

  factory SchedulerCoordinatorDashboardViewModel.assemble({
    required bool isOffline,
  }) {
    final base = PrimeCareDashboardViewModel.assemble(isOffline: isOffline);
    return SchedulerCoordinatorDashboardViewModel(
      isOfflineFallback: base.isOfflineFallback,
      kpis: base.kpis,
      recentActivity: base.recentActivity,
      blueprints: base.blueprints,
    );
  }
}
