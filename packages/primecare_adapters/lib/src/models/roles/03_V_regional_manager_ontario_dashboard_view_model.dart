// Layer: 03_VIEW_MODELS
import '../02_M_dashboard_view_model.dart';
import '../core/02_M_dashboard_models.dart';
import '../core/02_M_intelligence_insight.dart';
import '../core/02_M_ui_blueprint.dart';

class RegionalManagerOntarioDashboardViewModel extends PrimeCareDashboardViewModel {
  RegionalManagerOntarioDashboardViewModel({
    required super.metrics,
    required super.insights,
    super.blueprints,
    super.isOfflineFallback,
  });

  factory RegionalManagerOntarioDashboardViewModel.fromDashboardMetrics(DashboardMetrics metrics) {
    return RegionalManagerOntarioDashboardViewModel(
      metrics: metrics,
      insights: [],
    );
  }

  factory RegionalManagerOntarioDashboardViewModel.fromJson(Map<String, dynamic> json) {
    return RegionalManagerOntarioDashboardViewModel(
      metrics: DashboardMetrics.fromJson(json['metrics'] as Map<String, dynamic>? ?? {}),
      insights: (json['insights'] as List<dynamic>?)
              ?.map((e) => IntelligenceInsight.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      blueprints: (json['blueprints'] as List<dynamic>?)
              ?.map((e) => UIComponentBlueprint.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }

  factory RegionalManagerOntarioDashboardViewModel.empty({bool isOfflineFallback = false}) {
    return RegionalManagerOntarioDashboardViewModel(
      metrics: DashboardMetrics.empty(),
      insights: [],      isOfflineFallback: isOfflineFallback,
    );
  }

  @override
  Map<String, dynamic> toJson() => {
        'metrics': metrics.toJson(),
        'insights': insights.map((i) => i.toJson()).toList(),
        'blueprints': blueprints.map((b) => b.toJson()).toList(),
      };
}
