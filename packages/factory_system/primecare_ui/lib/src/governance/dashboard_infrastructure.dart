// Layer: 02_PRESENTATION_INFRASTRUCTURE
import 'package:primecare_ui/primecare_ui.dart';
import 'dart:async';

/// [Infrastructure] - Unified base for all Intelligence-driven Dashboards.
/// Handles state management, resilience, and telemetry for presenters.
abstract class IntegratedDashboardManager extends AsyncNotifier<Result<IntelligenceDashboardModel>> {
  /// The institutional role this dashboard serves.
  String get role;

  /// Unique key for local persistence.
  String get storageKey;

  @override
  FutureOr<Result<IntelligenceDashboardModel>> build() async {
    return loadDashboard();
  }

  /// Entry point for hydrating the dashboard with resilience logic.
  Future<Result<IntelligenceDashboardModel>> loadDashboard() async {
    final resilience = ref.read(resilienceServiceProvider);
    final telemetry = ref.read(executionGateProvider);

    try {
      final model = await fetchRemote(role);
      
      // Persist for offline resilience
      unawaited(resilience.saveSnapshot(storageKey, model.toJson()));
      
      telemetry.passGate(
        ExecutionGateCategory.domainApi,
        'Dashboard hydrated for role: $role',
      );
      
      return Success(model);
    } catch (e, st) {
      telemetry.failGate(
        ExecutionGateCategory.domainApi,
        'Dashboard hydration failed for role: $role',
        error: e,
        stackTrace: st,
      );

      // Attempt LKG restoration
      final snapshot = await resilience.getSnapshot(storageKey);
      if (snapshot != null) {
        return Success(IntelligenceDashboardModel.fromJson(snapshot).copyWith(isFromCache: true));
      }

      return Failure(e);
    }
  }

  /// Concrete implementations must provide the remote fetch logic.
  Future<IntelligenceDashboardModel> fetchRemote(String role);

  /// Triggers a manual refresh of the dashboard.
  Future<void> refresh() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => loadDashboard());
  }
}

/// [Model] - Precision data structure for AI-driven operational intelligence.
class IntelligenceDashboardModel {
  final DashboardMetrics metrics;
  final List<IntelligenceInsight> insights;
  final List<ActivityItem> timeline;
  final List<AnalyticsChart> trends;
  final bool isFromCache;
  final DateTime lastUpdated;

  IntelligenceDashboardModel({
    required this.metrics,
    required this.insights,
    required this.timeline,
    required this.trends,
    this.isFromCache = false,
    required this.lastUpdated,
  });

  factory IntelligenceDashboardModel.fromJson(Map<String, dynamic> json) {
    return IntelligenceDashboardModel(
      metrics: DashboardMetrics.fromJson((json['metrics'] as Map<String, dynamic>?) ?? {}),
      insights: (json['insights'] as List? ?? [])
          .map((i) => IntelligenceInsight.fromJson(i as Map<String, dynamic>))
          .toList(),
      timeline: (json['timeline'] as List? ?? [])
          .map((i) => ActivityItem.fromJson(i as Map<String, dynamic>))
          .toList(),
      trends: (json['trends'] as List? ?? [])
          .map((i) => AnalyticsChart.fromJson(i as Map<String, dynamic>))
          .toList(),
      isFromCache: json['isOfflineFallback'] as bool? ?? false,
      lastUpdated: DateTime.tryParse((json['lastUpdated'] as String?) ?? '') ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() => {
    'metrics': metrics.toJson(),
    'insights': insights.map((i) => i.toJson()).toList(),
    'timeline': timeline.map((i) => i.toJson()).toList(),
    'trends': trends.map((i) => i.toJson()).toList(),
    'isOfflineFallback': isFromCache,
    'lastUpdated': lastUpdated.toIso8601String(),
  };

  IntelligenceDashboardModel copyWith({
    DashboardMetrics? metrics,
    List<IntelligenceInsight>? insights,
    List<ActivityItem>? timeline,
    List<AnalyticsChart>? trends,
    bool? isFromCache,
    DateTime? lastUpdated,
  }) {
    return IntelligenceDashboardModel(
      metrics: metrics ?? this.metrics,
      insights: insights ?? this.insights,
      timeline: timeline ?? this.timeline,
      trends: trends ?? this.trends,
      isFromCache: isFromCache ?? this.isFromCache,
      lastUpdated: lastUpdated ?? this.lastUpdated,
    );
  }
}
