import 'package:primecare_core/flutter_core.dart';

class ClinicDashboardViewModel extends PrimeCareDashboardViewModel {
  const ClinicDashboardViewModel({
    super.isOfflineFallback,
    super.kpis,
    super.recentActivity,
    super.blueprints,
    super.forecasting,
  });

  factory ClinicDashboardViewModel.fromDashboardMetrics(
    DashboardMetrics metrics, {
    AIAnalyticsForecastingData? forecasting,
  }) {
    return ClinicDashboardViewModel(
      isOfflineFallback: false,
      kpis: metrics.kpis,
      recentActivity: metrics.recentActivity,
      forecasting: forecasting,
      blueprints: _buildBlueprints(
        metrics.kpis,
        metrics.recentActivity,
        forecasting,
      ),
    );
  }

  factory ClinicDashboardViewModel.fromJson(Map<String, dynamic> json) {
    final base = PrimeCareDashboardViewModel.fromJson(json);
    AIAnalyticsForecastingData? forecasting;
    if (json['forecasting'] != null) {
      forecasting = AIAnalyticsForecastingData.fromJson(
        json['forecasting'] as Map<String, dynamic>,
      );
    }

    return ClinicDashboardViewModel(
      isOfflineFallback: base.isOfflineFallback,
      kpis: base.kpis,
      recentActivity: base.recentActivity,
      blueprints: base.blueprints,
      forecasting: forecasting,
    );
  }

  factory ClinicDashboardViewModel.assemble({required bool isOffline}) {
    final metrics = DataLogisticsHub.getDashboardMetrics('clinic');
    return ClinicDashboardViewModel(
      isOfflineFallback: isOffline,
      kpis: metrics.kpis,
      recentActivity: metrics.recentActivity,
      blueprints: _buildBlueprints(metrics.kpis, metrics.recentActivity, null),
    );
  }

  static List<UIComponentBlueprint> _buildBlueprints(
    List<KpiMetric> kpis,
    List<DashboardActivity> recentActivity,
    AIAnalyticsForecastingData? forecasting,
  ) {
    final universalKpis = kpis
        .map(
          (k) => UniversalKpi(
            title: k.title,
            value: k.value,
            trend: double.tryParse(k.trend?.replaceAll('%', '') ?? '0') ?? 0.0,
            status: UniversalKpi.mapStatus(k.status),
          ),
        )
        .toList();

    return [
      if (forecasting != null) AIForecastingBlueprint(dataPayload: forecasting),
      StatGridBlueprint(dataPayload: universalKpis),
      const ClinicalMetricBlueprint(
        dataPayload: {
          'title': 'Clinical Intelligence',
          'metrics': [
            {'label': 'Care Quality', 'value': 0.96},
            {'label': 'Observation Accuracy', 'value': 0.92},
            {'label': 'Incident Reporting Rate', 'value': 0.98},
          ],
        },
      ),
      ActivityFeedBlueprint(
        dataPayload: recentActivity.map((e) => e.toJson()).toList(),
      ),
      const StitchBlueprint(screenId: 'd6b19469e4724705a405113ae8623ec2'),
    ];
  }
}
