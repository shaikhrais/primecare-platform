import 'package:primecare_adapters/primecare_adapters.dart';

class ClinicalDirectorDashboardViewModel extends PrimeCareDashboardViewModel {
  const ClinicalDirectorDashboardViewModel({
    required super.metrics,
    required super.insights,
    super.blueprints,
    super.isOfflineFallback,
  });

  factory ClinicalDirectorDashboardViewModel.fromDashboardMetrics(DashboardMetrics metrics) {
    return ClinicalDirectorDashboardViewModel(
      metrics: metrics,
      insights: const [],
    );
  }

  factory ClinicalDirectorDashboardViewModel.fromJson(Map<String, dynamic> json) {
    return ClinicalDirectorDashboardViewModel(
      metrics: DashboardMetrics.fromJson(json['metrics'] as Map<String, dynamic>? ?? {}),
      insights: (json['insights'] as List<dynamic>?)
              ?.map((e) => IntelligenceInsight.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      blueprints: (json['blueprints'] as List<dynamic>?)
              ?.map((e) => UIComponentBlueprint.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      isOfflineFallback: json['isOfflineFallback'] as bool? ?? false,
    );
  }

  factory ClinicalDirectorDashboardViewModel.empty({bool isOfflineFallback = false}) {
    return ClinicalDirectorDashboardViewModel(
      metrics: DashboardMetrics.empty(),
      insights: const [],
      isOfflineFallback: isOfflineFallback,
    );
  }

  @override
  Map<String, dynamic> toJson() => {
        'metrics': metrics.toJson(),
        'insights': insights.map((i) => i.toJson()).toList(),
        'blueprints': blueprints.map((b) => b.toJson()).toList(),
        'isOfflineFallback': isOfflineFallback,
      };
}
