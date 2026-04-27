import 'package:primecare_ui/primecare_ui.dart';

class ClinicDashboardModel {
  final DashboardMetrics metrics;
  final List<IntelligenceInsight> insights;
  final bool isOfflineFallback;

  ClinicDashboardModel({
    required this.metrics,
    required this.insights,
    this.isOfflineFallback = false,
  });

  factory ClinicDashboardModel.empty({bool isOfflineFallback = false}) {
    return ClinicDashboardModel(
      metrics: DashboardMetrics.empty(),
      insights: [],
      isOfflineFallback: isOfflineFallback,
    );
  }

  Map<String, dynamic> toJson() => {
        'metrics': metrics.toJson(),
        'insights': insights.map((i) => i.toJson()).toList(),
        'isOfflineFallback': isOfflineFallback,
      };

  factory ClinicDashboardModel.fromJson(Map<String, dynamic> json) =>
      ClinicDashboardModel(
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

// Add other models for clinic operations here
