import '../../../../dashboard_service.dart';
import '../../../../config/offline_fallback_state.dart';

class PrimeCareDashboardViewModel implements OfflineFallbackState {
  @override
  final bool isOfflineFallback;
  final List<KpiMetric> kpis;
  final List<DashboardActivity> recentActivity;
  final List<UIComponentBlueprint> blueprints;

  const PrimeCareDashboardViewModel({
    this.isOfflineFallback = false,
    this.kpis = const [],
    this.recentActivity = const [],
    this.blueprints = const [],
  });

  Map<String, dynamic> toJson() {
    return {
      'isOfflineFallback': isOfflineFallback,
      'kpis': kpis.map((k) => k.toJson()).toList(),
      'recentActivity': recentActivity.map((a) => a.toJson()).toList(),
      'blueprints': blueprints.map((b) => b.toJson()).toList(),
    };
  }

  factory PrimeCareDashboardViewModel.fromJson(Map<String, dynamic> json) {
    return PrimeCareDashboardViewModel(
      isOfflineFallback: json['isOfflineFallback'] as bool? ?? false,
      kpis:
          (json['kpis'] as List<dynamic>?)
              ?.map((k) => KpiMetric.fromJson(k as Map<String, dynamic>))
              .toList() ??
          const [],
      recentActivity:
          (json['recentActivity'] as List<dynamic>?)
              ?.map(
                (a) => DashboardActivity.fromJson(a as Map<String, dynamic>),
              )
              .toList() ??
          const [],
      blueprints:
          (json['blueprints'] as List<dynamic>?)
              ?.map(
                (b) => UIComponentBlueprint.fromJson(b as Map<String, dynamic>),
              )
              .toList() ??
          const [],
    );
  }

  factory PrimeCareDashboardViewModel.assemble({required bool isOffline}) {
    return PrimeCareDashboardViewModel(
      isOfflineFallback: isOffline,
      blueprints: [
        const StatGridBlueprint(dataPayload: []),
        const ActivityFeedBlueprint(dataPayload: []),
      ],
    );
  }

  factory PrimeCareDashboardViewModel.fromDashboardMetrics(
    DashboardMetrics metrics,
  ) {
    return PrimeCareDashboardViewModel(
      isOfflineFallback: false,
      kpis: metrics.kpis,
      recentActivity: metrics.recentActivity,
      blueprints: _generateBlueprints(metrics),
    );
  }

  static List<UIComponentBlueprint> _generateBlueprints(
    DashboardMetrics metrics,
  ) {
    return [
      StatGridBlueprint(
        dataPayload: metrics.kpis
            .map(
              (k) => UniversalKpi(
                title: k.title,
                value: k.value,
                trend: double.tryParse(k.trend ?? '0') ?? 0.0,
                status: UniversalKpi.mapStatus(k.status),
              ),
            )
            .toList(),
      ),
      if (metrics.recentActivity.isNotEmpty)
        ActivityFeedBlueprint(dataPayload: metrics.recentActivity),
    ];
  }
}
