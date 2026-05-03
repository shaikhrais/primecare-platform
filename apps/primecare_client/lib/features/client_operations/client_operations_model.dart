import 'package:primecare_ui/primecare_ui.dart';

class ClientDashboardModel {
  final DashboardMetrics metrics;
  final List<IntelligenceInsight> insights;
  final bool isOfflineFallback;

  ClientDashboardModel({
    required this.metrics,
    required this.insights,
    this.isOfflineFallback = false,
  });

  ClientDashboardModel copyWith({
    DashboardMetrics? metrics,
    List<IntelligenceInsight>? insights,
    bool? isOfflineFallback,
  }) {
    return ClientDashboardModel(
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

  factory ClientDashboardModel.fromJson(Map<String, dynamic> json) =>
      ClientDashboardModel(
        metrics: DashboardMetrics.fromJson(json['metrics'] as Map<String, dynamic>),
        insights: (json['insights'] as List)
            .map((i) => IntelligenceInsight.fromJson(i as Map<String, dynamic>))
            .toList(),
        isOfflineFallback: json['isOfflineFallback'] as bool? ?? false,
      );

  factory ClientDashboardModel.empty({bool isOfflineFallback = false}) =>
      ClientDashboardModel(
        metrics: DashboardMetrics.empty(),
        insights: [],
        isOfflineFallback: isOfflineFallback,
      );
}
