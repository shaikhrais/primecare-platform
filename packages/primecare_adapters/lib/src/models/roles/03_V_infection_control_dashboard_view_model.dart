// Layer: 03_VIEW_MODELS
import '../02_M_dashboard_view_model.dart';
import '../core/02_M_dashboard_models.dart';
import '../core/02_M_intelligence_insight.dart';
import '../core/02_M_ui_blueprint.dart';

class InfectionControlDashboardViewModel extends PrimeCareDashboardViewModel {
  InfectionControlDashboardViewModel({
    required super.metrics,
    required super.insights,
    super.blueprints,
    super.isOfflineFallback,
  });

  factory InfectionControlDashboardViewModel.fromDashboardMetrics(
    DashboardMetrics metrics,
  ) {
    return InfectionControlDashboardViewModel(metrics: metrics, insights: []);
  }

  factory InfectionControlDashboardViewModel.fromJson(
    Map<String, dynamic> json,
  ) {
    return InfectionControlDashboardViewModel(
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

  factory InfectionControlDashboardViewModel.empty({
    bool isOfflineFallback = false,
  }) {
    return InfectionControlDashboardViewModel(
      metrics: DashboardMetrics.empty(),
      insights: [],
      isOfflineFallback: isOfflineFallback,
    );
  }

  InfectionControlDashboardViewModel copyWith({
    DashboardMetrics? metrics,
    List<IntelligenceInsight>? insights,
    List<UIComponentBlueprint>? blueprints,
    bool? isOfflineFallback,
  }) {
    return InfectionControlDashboardViewModel(
      metrics: metrics ?? this.metrics,
      insights: insights ?? this.insights,
      blueprints: blueprints ?? this.blueprints,
      isOfflineFallback: isOfflineFallback ?? this.isOfflineFallback,
    );
  }

  @override
  Map<String, dynamic> toJson() => {
    'metrics': metrics.toJson(),
    'insights': insights.map((i) => i.toJson()).toList(),
    'blueprints': blueprints.map((b) => b.toJson()).toList(),
  };
}
