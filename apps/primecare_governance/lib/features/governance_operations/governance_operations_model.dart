import 'package:primecare_adapters/primecare_adapters.dart';

class GovernanceDashboardModel {
  final DashboardMetrics metrics;
  final List<IntelligenceInsight> insights;
  final bool isOfflineFallback;

  GovernanceDashboardModel({
    required this.metrics,
    required this.insights,
    this.isOfflineFallback = false,
  });

  GovernanceDashboardModel copyWith({
    DashboardMetrics? metrics,
    List<IntelligenceInsight>? insights,
    bool? isOfflineFallback,
  }) {
    return GovernanceDashboardModel(
      metrics: metrics ?? this.metrics,
      insights: insights ?? this.insights,
      isOfflineFallback: isOfflineFallback ?? this.isOfflineFallback,
    );
  }

  Map<String, dynamic> toJson() => {
        'metrics': metrics.toJson(),
        'insights': insights.map((i) => i.toJson()).toList(),
        'isOfflineFallback': isOfflineFallback,
      };

  factory GovernanceDashboardModel.fromJson(Map<String, dynamic> json) =>
      GovernanceDashboardModel(
        metrics: DashboardMetrics.fromJson(json['metrics']),
        insights: (json['insights'] as List)
            .map((i) => IntelligenceInsight.fromJson(i))
            .toList(),
        isOfflineFallback: json['isOfflineFallback'] ?? false,
      );

  factory GovernanceDashboardModel.empty({bool isOfflineFallback = false}) =>
      GovernanceDashboardModel(
        metrics: DashboardMetrics.empty(),
        insights: [],
        isOfflineFallback: isOfflineFallback,
      );
}
