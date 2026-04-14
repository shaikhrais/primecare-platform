import '../../../common/domain/models/primecare_dashboard_view_model.dart';
import '../../../../dashboard_service.dart';

class QualityAssuranceDashboardViewModel extends PrimeCareDashboardViewModel {
  const QualityAssuranceDashboardViewModel({
    super.isOfflineFallback = false,
    super.kpis = const [],
    super.recentActivity = const [],
    super.blueprints = const [],
  });

  factory QualityAssuranceDashboardViewModel.fromJson(Map<String, dynamic> json) {
    final base = PrimeCareDashboardViewModel.fromJson(json);
    return QualityAssuranceDashboardViewModel(
      isOfflineFallback: base.isOfflineFallback,
      kpis: base.kpis,
      recentActivity: base.recentActivity,
      blueprints: base.blueprints,
    );
  }

  factory QualityAssuranceDashboardViewModel.fromDashboardMetrics(
    DashboardMetrics metrics,
  ) {
    final base = PrimeCareDashboardViewModel.fromDashboardMetrics(metrics);
    return QualityAssuranceDashboardViewModel(
      isOfflineFallback: base.isOfflineFallback,
      kpis: base.kpis,
      recentActivity: base.recentActivity,
      blueprints: base.blueprints,
    );
  }

  factory QualityAssuranceDashboardViewModel.assemble({required bool isOffline}) {
    final base = PrimeCareDashboardViewModel.assemble(isOffline: isOffline);
    return QualityAssuranceDashboardViewModel(
      isOfflineFallback: base.isOfflineFallback,
      kpis: base.kpis,
      recentActivity: base.recentActivity,
      blueprints: base.blueprints,
    );
  }
}
