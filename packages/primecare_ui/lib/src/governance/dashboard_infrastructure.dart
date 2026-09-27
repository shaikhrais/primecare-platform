import 'package:flutter_riverpod/legacy.dart';
// Governance - Category: view | Purpose: Layer: 02_PRESENTATION_INFRASTRUCTURE [FamilyManager] - Parameterized manager for role-based dashboards. Entry point ...
// Layer: 02_PRESENTATION_INFRASTRUCTURE
import 'package:primecare_ui/primecare_ui.dart';
import 'dart:async';

/// [FamilyManager] - Parameterized manager for role-based dashboards.
class IntegratedDashboardFamilyManager
    extends StateNotifier<AsyncValue<Result<IntelligenceDashboardModel>>> {
  final Ref ref;
  final String role;
  final String storageKey;

  IntegratedDashboardFamilyManager({
    required this.ref,
    required this.role,
    required this.storageKey,
  }) : super(const AsyncValue.loading()) {
    loadDashboard();
  }

  /// Entry point for hydrating the dashboard with resilience logic.
  Future<void> loadDashboard() async {
    state = const AsyncValue.loading();
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

      state = AsyncValue.data(Success(model));
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
        try {
          final cachedModel = IntelligenceDashboardModel.fromJson(
            Map<String, dynamic>.from(snapshot),
          ).copyWith(isFromCache: true);
          state = AsyncValue.data(Success(cachedModel));
          return;
        } catch (_) {}
      }

      state = AsyncValue.data(Failure(e));
    }
  }

  /// Concrete remote fetch implementation for the role.
  Future<IntelligenceDashboardModel> fetchRemote(String role) async {
    // Standard mock API call simulated in executive dashboard logic to prevent drift:
    await Future<void>.delayed(const Duration(milliseconds: 600));

    // Construct highly robust, structured metric data to avoid string interpolation/format error
    return IntelligenceDashboardModel(
      metrics: DashboardMetrics(
        kpis: Map<String, dynamic>.from({
          'activeUsers': 1250,
          'complianceRate': 98.5,
          'pendingAudits': 2,
          'efficiencyIndex': 94.2,
        }),
        charts: [
          const AnalyticsChart(
            id: 'trend-1',
            title: 'Weekly Alignment Index',
            type: ChartType.line,
            dataPoints: [
              DataPoint(label: 'Mon', value: 92.0),
              DataPoint(label: 'Tue', value: 94.5),
              DataPoint(label: 'Wed', value: 95.0),
              DataPoint(label: 'Thu', value: 96.2),
              DataPoint(label: 'Fri', value: 98.5),
            ],
          ),
        ],
        recentActivity: [
          ActivityItem(
            id: 'act-1',
            title: 'System Decompression Sync',
            subtitle: 'Verified all skeletal registry invariants.',
            timestamp: DateTime.now(),
          ),
        ],
        insights: [
          const IntelligenceInsight(
            id: 'ins-1',
            title: 'Governance Threshold Passed',
            summary: 'Active components demonstrate 100% telemetry validation.',
            impact: InsightImpact.positive,
          ),
        ],
      ),
      insights: [
        const IntelligenceInsight(
          id: 'ins-2',
          title: 'Optimal Performance Active',
          summary: 'No active discrepancies found across clinics.',
          impact: InsightImpact.info,
        ),
      ],
      timeline: [
        ActivityItem(
          id: 'time-1',
          title: 'Security Sync Complete',
          subtitle: 'Active credentials verified.',
          timestamp: DateTime.now(),
        ),
      ],
      trends: [
        const AnalyticsChart(
          id: 'trend-2',
          title: 'Operational Velocity',
          type: ChartType.bar,
          dataPoints: [
            DataPoint(label: 'Week 1', value: 85.0),
            DataPoint(label: 'Week 2', value: 90.0),
            DataPoint(label: 'Week 3', value: 95.0),
          ],
        ),
      ],
      lastUpdated: DateTime.now(),
    );
  }

  /// Triggers a manual refresh of the dashboard.
  Future<void> refresh() async {
    await loadDashboard();
  }
}

/// [CorporateDashboardController] - Controller managing the Corporate-level dashboard state.
class CorporateDashboardController extends IntegratedDashboardFamilyManager {
  CorporateDashboardController({required super.ref})
      : super(
          role: 'corporate',
          storageKey: 'primecare_dashboard_snapshot_corporate',
        );
}

/// [FranchiseDashboardControllerCore] - Core controller managing Franchise-level dashboard state.
class FranchiseDashboardControllerCore extends IntegratedDashboardFamilyManager {
  FranchiseDashboardControllerCore({required super.ref})
      : super(
          role: 'franchise',
          storageKey: 'primecare_dashboard_snapshot_franchise',
        );
}

/// --- Providers ---

final integratedDashboardFamilyProvider = StateNotifierProvider.family<
    IntegratedDashboardFamilyManager,
    AsyncValue<Result<IntelligenceDashboardModel>>,
    String>((ref, role) {
  return IntegratedDashboardFamilyManager(
    ref: ref,
    role: role,
    storageKey: 'primecare_dashboard_snapshot_$role',
  );
});

final corporateDashboardProviderCore = StateNotifierProvider<
    CorporateDashboardController,
    AsyncValue<Result<IntelligenceDashboardModel>>>((ref) {
  return CorporateDashboardController(ref: ref);
});

final franchiseDashboardProviderCore = StateNotifierProvider<
    FranchiseDashboardControllerCore,
    AsyncValue<Result<IntelligenceDashboardModel>>>((ref) {
  return FranchiseDashboardControllerCore(ref: ref);
});

/// [Infrastructure] - Unified base for all Intelligence-driven Dashboards (Legacy).
/// Handles state management, resilience, and telemetry for presenters.
abstract class IntegratedDashboardManager
    extends AsyncNotifier<Result<IntelligenceDashboardModel>> {
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
        return Success(
          IntelligenceDashboardModel.fromJson(
            Map<String, dynamic>.from(snapshot),
          ).copyWith(isFromCache: true),
        );
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
      metrics: DashboardMetrics.fromJson(
        (json['metrics'] is Map) ? Map<String, dynamic>.from(json['metrics'] as Map) : {},
      ),
      insights: (json['insights'] is List)
          ? (json['insights'] as List)
              .map((i) => IntelligenceInsight.fromJson(Map<String, dynamic>.from(i as Map)))
              .toList()
          : [],
      timeline: (json['timeline'] is List)
          ? (json['timeline'] as List)
              .map((i) => ActivityItem.fromJson(Map<String, dynamic>.from(i as Map)))
              .toList()
          : [],
      trends: (json['trends'] is List)
          ? (json['trends'] as List)
              .map((i) => AnalyticsChart.fromJson(Map<String, dynamic>.from(i as Map)))
              .toList()
          : [],
      isFromCache: json['isOfflineFallback'] as bool? ?? false,
      lastUpdated:
          DateTime.tryParse((json['lastUpdated'] as String?) ?? '') ??
          DateTime.now(),
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
