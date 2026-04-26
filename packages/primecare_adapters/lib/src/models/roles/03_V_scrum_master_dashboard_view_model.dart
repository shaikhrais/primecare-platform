// Layer: 03_VIEW_MODELS
import '../02_M_dashboard_view_model.dart';
import '../core/02_M_dashboard_models.dart';
import '../core/02_M_intelligence_insight.dart';
import '../core/02_M_ui_blueprint.dart';

class ScrumMasterDashboardViewModel extends PrimeCareDashboardViewModel {
  ScrumMasterDashboardViewModel({
    required super.metrics,
    required super.insights,
    super.blueprints,
    super.isOfflineFallback,
  });

  factory ScrumMasterDashboardViewModel.fromDashboardMetrics(
    DashboardMetrics metrics,
  ) {
    return ScrumMasterDashboardViewModel(metrics: metrics, insights: []);
  }

  factory ScrumMasterDashboardViewModel.fromJson(Map<String, dynamic> json) {
    return ScrumMasterDashboardViewModel(
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

  factory ScrumMasterDashboardViewModel.empty({
    bool isOfflineFallback = false,
  }) {
    return ScrumMasterDashboardViewModel(
      metrics: DashboardMetrics.empty(),
      insights: [],
      isOfflineFallback: isOfflineFallback,
    );
  }

  ScrumMasterDashboardViewModel copyWith({
    DashboardMetrics? metrics,
    List<IntelligenceInsight>? insights,
    List<UIComponentBlueprint>? blueprints,
    bool? isOfflineFallback,
  }) {
    return ScrumMasterDashboardViewModel(
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
