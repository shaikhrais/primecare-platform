import 'package:primecare_ui/primecare_ui.dart';

class CorporateDashboardModel {
  final DashboardMetrics metrics;
  final List<IntelligenceInsight> insights;
  final bool isOfflineFallback;

  CorporateDashboardModel({
    required this.metrics,
    required this.insights,
    this.isOfflineFallback = false,
  });

  factory CorporateDashboardModel.empty({bool isOfflineFallback = false}) {
    return CorporateDashboardModel(
      metrics: DashboardMetrics.empty(),
      insights: [],
      isOfflineFallback: isOfflineFallback,
    );
  }

  CorporateDashboardModel copyWith({bool? isOfflineFallback}) {
    return CorporateDashboardModel(
      metrics: metrics,
      insights: insights,
      isOfflineFallback: isOfflineFallback ?? this.isOfflineFallback,
    );
  }

  Map<String, dynamic> toJson() => {
        'metrics': metrics.toJson(),
        'insights': insights.map((i) => i.toJson()).toList(),
        'isOfflineFallback': isOfflineFallback,
      };

  factory CorporateDashboardModel.fromJson(Map<String, dynamic> json) =>
      CorporateDashboardModel(
        metrics: DashboardMetrics.fromJson(json['metrics']),
        insights: (json['insights'] as List)
            .map((i) => IntelligenceInsight.fromJson(i))
            .toList(),
        isOfflineFallback: json['isOfflineFallback'] ?? false,
      );

  List<AssemblyBlueprint> get blueprints {
    return [
      AssemblyBlueprint(
        componentType: 'kpi_grid',
        dataPayload: metrics.kpis,
      ),
      AssemblyBlueprint(
        componentType: 'activity_feed',
        dataPayload: metrics.recentActivity,
      ),
    ];
  }
}
