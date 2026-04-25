// Layer: 03_VIEW_MODELS
import '../02_M_dashboard_view_model.dart';
import '../core/02_M_dashboard_models.dart';
import '../core/02_M_intelligence_insight.dart';
import '../core/02_M_ui_blueprint.dart';

class ClinicalDirectorDashboardViewModel extends PrimeCareDashboardViewModel {
  final AnalyticsChart staffingHeatmap;
  final AnalyticsChart incidentTrends;

  ClinicalDirectorDashboardViewModel({
    required super.metrics,
    required super.insights,
    required this.staffingHeatmap,
    required this.incidentTrends,
    super.blueprints,
    super.isOfflineFallback,
  });

  factory ClinicalDirectorDashboardViewModel.fromDashboardMetrics(
    DashboardMetrics metrics,
  ) {
    return ClinicalDirectorDashboardViewModel(
      metrics: metrics,
      insights: [],
      staffingHeatmap: AnalyticsChart.empty(),
      incidentTrends: AnalyticsChart.empty(),
    );
  }

  factory ClinicalDirectorDashboardViewModel.fromJson(
    Map<String, dynamic> json,
  ) {
    return ClinicalDirectorDashboardViewModel(
      metrics: DashboardMetrics.fromJson(
        json['metrics'] as Map<String, dynamic>? ?? {},
      ),
      insights:
          (json['insights'] as List<dynamic>?)
              ?.map(
                (e) => IntelligenceInsight.fromJson(e as Map<String, dynamic>),
              )
              .toList() ??
          [],
      staffingHeatmap: AnalyticsChart.fromJson(
        json['staffingHeatmap'] as Map<String, dynamic>? ?? {},
      ),
      incidentTrends: AnalyticsChart.fromJson(
        json['incidentTrends'] as Map<String, dynamic>? ?? {},
      ),
      blueprints:
          (json['blueprints'] as List<dynamic>?)
              ?.map(
                (e) => UIComponentBlueprint.fromJson(e as Map<String, dynamic>),
              )
              .toList() ??
          [],
      isOfflineFallback: json['isOfflineFallback'] as bool? ?? false,
    );
  }

  factory ClinicalDirectorDashboardViewModel.empty({
    bool isOfflineFallback = false,
  }) {
    return ClinicalDirectorDashboardViewModel(
      metrics: DashboardMetrics.empty(),
      insights: [],
      staffingHeatmap: AnalyticsChart.empty(),
      incidentTrends: AnalyticsChart.empty(),
      isOfflineFallback: isOfflineFallback,
    );
  }

  @override
  Map<String, dynamic> toJson() => {
    'metrics': metrics.toJson(),
    'insights': insights.map((i) => i.toJson()).toList(),
    'staffingHeatmap': staffingHeatmap.toJson(),
    'incidentTrends': incidentTrends.toJson(),
    'blueprints': blueprints.map((b) => b.toJson()).toList(),
    'isOfflineFallback': isOfflineFallback,
  };
}
