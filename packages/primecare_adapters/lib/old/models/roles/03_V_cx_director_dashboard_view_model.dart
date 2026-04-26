import 'package:primecare_adapters/primecare_adapters.dart';
import 'package:easy_localization/easy_localization.dart';
// Layer: 03_VIEW_MODELS

class CXDirectorDashboardViewModel extends PrimeCareDashboardViewModel {
  final String title;

  CXDirectorDashboardViewModel({
    required this.title,
    required super.metrics,
    required super.insights,
    super.blueprints,
    super.isOfflineFallback,
  });

  factory CXDirectorDashboardViewModel.fromJson(Map<String, dynamic> json) {
    return CXDirectorDashboardViewModel(
      title: json['title'] as String? ?? 'CX Director Dashboard',
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

  factory CXDirectorDashboardViewModel.empty({bool isOfflineFallback = false}) {
    return CXDirectorDashboardViewModel(
      title: LocaleKeys.dashboards_common_labels_cx_director_dashboard.tr(),
      metrics: DashboardMetrics.empty(),
      insights: [],
      isOfflineFallback: isOfflineFallback,
    );
  }

  @override
  Map<String, dynamic> toJson() => {
    'title': title,
    'metrics': metrics.toJson(),
    'insights': insights.map((i) => i.toJson()).toList(),
    'blueprints': blueprints.map((b) => b.toJson()).toList(),
  };

  CXDirectorDashboardViewModel copyWith({
    String? title,
    DashboardMetrics? metrics,
    List<IntelligenceInsight>? insights,
    List<UIComponentBlueprint>? blueprints,
    bool? isOfflineFallback,
  }) {
    return CXDirectorDashboardViewModel(
      title: title ?? this.title,
      metrics: metrics ?? this.metrics,
      insights: insights ?? this.insights,
      blueprints: blueprints ?? this.blueprints,
      isOfflineFallback: isOfflineFallback ?? this.isOfflineFallback,
    );
  }
}
