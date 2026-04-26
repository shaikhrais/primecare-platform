import 'package:primecare_adapters/src/models/02_M_dashboard_view_model.dart';
import 'package:primecare_adapters/src/models/core/02_M_dashboard_models.dart';
import 'package:primecare_adapters/src/models/core/02_M_intelligence_insight.dart';

class ArchitecturePlanningViewModel extends PrimeCareDashboardViewModel {
  const ArchitecturePlanningViewModel({
    required super.metrics,
    required super.insights,
    super.isOfflineFallback,
  });

  factory ArchitecturePlanningViewModel.fromJson(Map<String, dynamic> json) {
    return ArchitecturePlanningViewModel(
      metrics: DashboardMetrics.fromJson(
        json['metrics'] as Map<String, dynamic>,
      ),
      insights:
          (json['insights'] as List<dynamic>?)
              ?.map(
                (e) => IntelligenceInsight.fromJson(e as Map<String, dynamic>),
              )
              .toList() ??
          [],
      isOfflineFallback: json['isOfflineFallback'] as bool? ?? false,
    );
  }

  factory ArchitecturePlanningViewModel.empty({
    bool isOfflineFallback = false,
  }) {
    return ArchitecturePlanningViewModel(
      metrics: DashboardMetrics.empty(),
      insights: const [],
      isOfflineFallback: isOfflineFallback,
    );
  }

  ArchitecturePlanningViewModel copyWith({
    DashboardMetrics? metrics,
    List<IntelligenceInsight>? insights,
    bool? isOfflineFallback,
  }) {
    return ArchitecturePlanningViewModel(
      metrics: metrics ?? this.metrics,
      insights: insights ?? this.insights,
      isOfflineFallback: isOfflineFallback ?? this.isOfflineFallback,
    );
  }
}
