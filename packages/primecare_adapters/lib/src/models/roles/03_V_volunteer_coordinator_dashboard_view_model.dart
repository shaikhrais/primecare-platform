// Layer: 03_VIEW_MODELS
import '../02_M_dashboard_view_model.dart';
import '../core/02_M_dashboard_models.dart';
import '../core/02_M_intelligence_insight.dart';
import '../core/02_M_ui_blueprint.dart';

class VolunteerCoordinatorDashboardViewModel
    extends PrimeCareDashboardViewModel {
  final String title;

  VolunteerCoordinatorDashboardViewModel({
    required this.title,
    required super.metrics,
    required super.insights,
    super.blueprints,
    super.isOfflineFallback,
  });

  factory VolunteerCoordinatorDashboardViewModel.fromJson(
    Map<String, dynamic> json,
  ) {
    return VolunteerCoordinatorDashboardViewModel(
      title: json['title'] as String? ?? 'Volunteer Coordinator Dashboard',
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

  factory VolunteerCoordinatorDashboardViewModel.empty({
    bool isOfflineFallback = false,
  }) {
    return VolunteerCoordinatorDashboardViewModel(
      title: 'Volunteer Coordinator Dashboard',
      metrics: DashboardMetrics.empty(),
      insights: [],
      isOfflineFallback: isOfflineFallback,
    );
  }

  VolunteerCoordinatorDashboardViewModel copyWith({
    String? title,
    DashboardMetrics? metrics,
    List<IntelligenceInsight>? insights,
    List<UIComponentBlueprint>? blueprints,
    bool? isOfflineFallback,
  }) {
    return VolunteerCoordinatorDashboardViewModel(
      title: title ?? this.title,
      metrics: metrics ?? this.metrics,
      insights: insights ?? this.insights,
      blueprints: blueprints ?? this.blueprints,
      isOfflineFallback: isOfflineFallback ?? this.isOfflineFallback,
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
