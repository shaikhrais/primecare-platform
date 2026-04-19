import '../../../common/domain/models/primecare_dashboard_view_model.dart';
import '../../../../dashboard_service.dart';

class RegionalManagerUsaDashboardViewModel extends PrimeCareDashboardViewModel {
  const RegionalManagerUsaDashboardViewModel({
    super.isOfflineFallback = false,
    super.kpis = const [],
    super.recentActivity = const [],
    super.blueprints = const [],
    super.forecasting,
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
      forecasting: base.forecasting,
    );
  }

  factory RegionalManagerUsaDashboardViewModel.fromDashboardMetrics(
    DashboardMetrics metrics, {
    AIAnalyticsForecastingData? forecasting,
  }) {
    final base = PrimeCareDashboardViewModel.fromDashboardMetrics(
      metrics,
      forecasting: forecasting,
    );
    return RegionalManagerUsaDashboardViewModel(
      isOfflineFallback: base.isOfflineFallback,
      kpis: base.kpis,
      recentActivity: base.recentActivity,
      blueprints: base.blueprints,
      forecasting: base.forecasting,
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
