// Layer: 03_VIEW_MODELS
import '../02_M_dashboard_view_model.dart';
import '../core/02_M_dashboard_models.dart';
import '../core/02_M_intelligence_insight.dart';
import '../core/02_M_ui_blueprint.dart';

/// ViewModel for the IT Security Dashboard.
/// Tracks cyber-shield telemetry, threat logs, and system integrity.
class ITSecurityDashboardViewModel extends PrimeCareDashboardViewModel {
  ITSecurityDashboardViewModel({
    required super.metrics,
    required super.insights,
    super.blueprints,
    super.isOfflineFallback,
  });

  factory ITSecurityDashboardViewModel.fromDashboardMetrics(
    DashboardMetrics metrics,
  ) {
    return ITSecurityDashboardViewModel(
      metrics: metrics,
      insights: metrics.insights
          .map((i) => IntelligenceInsight.fromDashboardInsight(i))
          .toList(),
    );
  }

  factory ITSecurityDashboardViewModel.fromJson(Map<String, dynamic> json) {
    return ITSecurityDashboardViewModel(
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
      blueprints:
          (json['blueprints'] as List<dynamic>?)
              ?.map(
                (e) => UIComponentBlueprint.fromJson(e as Map<String, dynamic>),
              )
              .toList() ??
          [],
    );
  }

  factory ITSecurityDashboardViewModel.empty({bool isOfflineFallback = false}) {
    return ITSecurityDashboardViewModel(
      metrics: DashboardMetrics.empty(),
      insights: [],
      isOfflineFallback: isOfflineFallback,
    );
  }

  @override
  Map<String, dynamic> toJson() => {
    'metrics': metrics.toJson(),
    'insights': insights.map((i) => i.toJson()).toList(),
    'blueprints': blueprints.map((b) => b.toJson()).toList(),
  };

  ITSecurityDashboardViewModel copyWith({
    DashboardMetrics? metrics,
    List<IntelligenceInsight>? insights,
    List<UIComponentBlueprint>? blueprints,
    bool? isOfflineFallback,
  }) {
    return ITSecurityDashboardViewModel(
      metrics: metrics ?? this.metrics,
      insights: insights ?? this.insights,
      blueprints: blueprints ?? this.blueprints,
      isOfflineFallback: isOfflineFallback ?? this.isOfflineFallback,
    );
  }
}
