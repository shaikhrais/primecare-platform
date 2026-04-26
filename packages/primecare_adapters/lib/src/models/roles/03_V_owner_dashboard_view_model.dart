// Layer: 03_VIEW_MODELS
import '../02_M_dashboard_view_model.dart';
import '../core/02_M_dashboard_models.dart';
import '../core/02_M_intelligence_insight.dart';
import '../core/02_M_ui_blueprint.dart';

class OwnerDashboardViewModel extends PrimeCareDashboardViewModel {
  OwnerDashboardViewModel({
    required super.metrics,
    required super.insights,
    super.blueprints,
    super.isOfflineFallback,
  });

  factory OwnerDashboardViewModel.fromDashboardMetrics(
    DashboardMetrics metrics,
  ) {
    return OwnerDashboardViewModel(metrics: metrics, insights: []);
  }

  factory OwnerDashboardViewModel.fromJson(Map<String, dynamic> json) {
    return OwnerDashboardViewModel(
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

  factory OwnerDashboardViewModel.empty({bool isOfflineFallback = false}) {
    return OwnerDashboardViewModel(
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

  OwnerDashboardViewModel copyWith({
    DashboardMetrics? metrics,
    List<IntelligenceInsight>? insights,
    List<UIComponentBlueprint>? blueprints,
    bool? isOfflineFallback,
  }) {
    return OwnerDashboardViewModel(
      metrics: metrics ?? this.metrics,
      insights: insights ?? this.insights,
      blueprints: blueprints ?? this.blueprints,
      isOfflineFallback: isOfflineFallback ?? this.isOfflineFallback,
    );
  }
}
