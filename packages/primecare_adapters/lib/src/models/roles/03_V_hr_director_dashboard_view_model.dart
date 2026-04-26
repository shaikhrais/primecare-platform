import 'package:primecare_adapters/primecare_adapters.dart';
import 'package:easy_localization/easy_localization.dart';
// Layer: 03_VIEW_MODELS

class HumanResourcesDirectorDashboardViewModel
    extends PrimeCareDashboardViewModel {
  final String title;

  HumanResourcesDirectorDashboardViewModel({
    required this.title,
    required super.metrics,
    required super.insights,
    super.blueprints,
    super.isOfflineFallback,
  });

  factory HumanResourcesDirectorDashboardViewModel.fromJson(
    Map<String, dynamic> json,
  ) {
    return HumanResourcesDirectorDashboardViewModel(
      title: json['title'] as String? ?? 'HR Director Dashboard',
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

  factory HumanResourcesDirectorDashboardViewModel.empty({
    bool isOfflineFallback = false,
  }) {
    return HumanResourcesDirectorDashboardViewModel(
      title: LocaleKeys.dashboards_common_labels_hr_director_dashboard.tr(),
      metrics: DashboardMetrics.empty(),
      insights: [],
      isOfflineFallback: isOfflineFallback,
    );
  }

  HumanResourcesDirectorDashboardViewModel copyWith({
    String? title,
    DashboardMetrics? metrics,
    List<IntelligenceInsight>? insights,
    List<UIComponentBlueprint>? blueprints,
    bool? isOfflineFallback,
  }) {
    return HumanResourcesDirectorDashboardViewModel(
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
