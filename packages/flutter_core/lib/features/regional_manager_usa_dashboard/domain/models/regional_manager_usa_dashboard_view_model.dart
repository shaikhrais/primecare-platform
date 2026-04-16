import '../../../common/domain/models/primecare_dashboard_view_model.dart';
import '../../../../dashboard_service.dart';

class RegionalManagerUsaDashboardViewModel extends PrimeCareDashboardViewModel {
  const RegionalManagerUsaDashboardViewModel({
    super.isOfflineFallback = false,
    super.kpis = const [],
    super.recentActivity = const [],
    super.blueprints = const [],
  });

  factory RegionalManagerUsaDashboardViewModel.fromJson(
    Map<String, dynamic> json,
  ) {
    final base = PrimeCareDashboardViewModel.fromJson(json);
    return RegionalManagerUsaDashboardViewModel(
      isOfflineFallback: base.isOfflineFallback,
      kpis: base.kpis,
      recentActivity: base.recentActivity,
      blueprints: base.blueprints,
    );
  }

  factory RegionalManagerUsaDashboardViewModel.fromDashboardMetrics(
    DashboardMetrics metrics,
  ) {
    final base = PrimeCareDashboardViewModel.fromDashboardMetrics(metrics);
    return RegionalManagerUsaDashboardViewModel(
      isOfflineFallback: base.isOfflineFallback,
      kpis: base.kpis,
      recentActivity: base.recentActivity,
      blueprints: base.blueprints,
    );
  }

  factory RegionalManagerUsaDashboardViewModel.assemble({
    required bool isOffline,
  }) {
    final base = PrimeCareDashboardViewModel.assemble(isOffline: isOffline);
    return RegionalManagerUsaDashboardViewModel(
      isOfflineFallback: base.isOfflineFallback,
      kpis: base.kpis,
      recentActivity: base.recentActivity,
      blueprints: base.blueprints,
    );
  }
}
