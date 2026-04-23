// Layer: 03_VIEW_MODELS
import '../02_M_dashboard_view_model.dart';
import '../core/02_M_dashboard_models.dart';
import '../core/02_M_intelligence_insight.dart';
import '../core/02_M_ui_blueprint.dart';

class CustomerExperienceDirectorDashboardViewModel extends PrimeCareDashboardViewModel {
  final String title;

  CustomerExperienceDirectorDashboardViewModel({
    required this.title,
    required super.metrics,
    required super.insights,
    super.blueprints,
    super.isOfflineFallback,
  });

  factory CustomerExperienceDirectorDashboardViewModel.fromJson(Map<String, dynamic> json) {
    return CustomerExperienceDirectorDashboardViewModel(
      title: json['title'] as String? ?? 'CX Director Dashboard',
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

  @override
  Map<String, dynamic> toJson() => {
        'title': title,
        'metrics': metrics.toJson(),
        'insights': insights.map((i) => i.toJson()).toList(),
        'blueprints': blueprints.map((b) => b.toJson()).toList(),
      };
}
