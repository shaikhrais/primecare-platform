// Layer: 02_MODELS_FOUNDATION
import '02_M_view_model.dart';
import 'core/02_M_dashboard_models.dart';
import 'core/02_M_ui_blueprint.dart';
import 'core/02_M_intelligence_insight.dart';

/// Base class for all high-fidelity Dashboard ViewModels.
/// Enforces the registry-aware skeletal structure and Blueprint-driven UI.
class PrimeCareDashboardViewModel extends PrimeCareViewModel {
  final DashboardMetrics metrics;
  final List<IntelligenceInsight> insights;
  final List<UIComponentBlueprint> blueprints;

  const PrimeCareDashboardViewModel({
    required this.metrics,
    required this.insights,
    this.blueprints = const [],
    super.isOfflineFallback,
    super.version,
  });

  List<KpiMetric> get kpis => metrics.kpis;
  List<DashboardActivity> get recentActivity => metrics.recentActivity;

  factory PrimeCareDashboardViewModel.fromJson(Map<String, dynamic> json) {
    return PrimeCareDashboardViewModel(
      isOfflineFallback: json['isOfflineFallback'] as bool? ?? false,
      version: json['version'] as String?,
      metrics: DashboardMetrics.fromJson(json['metrics'] as Map<String, dynamic>),
      insights: (json['insights'] as List<dynamic>?)
              ?.map((e) => IntelligenceInsight.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      blueprints: (json['blueprints'] as List<dynamic>?)
              ?.map((e) => UIComponentBlueprint.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }

  factory PrimeCareDashboardViewModel.fromDashboardMetrics(
    DashboardMetrics metrics,
  ) {
    return PrimeCareDashboardViewModel(metrics: metrics, insights: const []);
  }

  @override
  Map<String, dynamic> toJson() => {
        'metrics': metrics.toJson(),
        'insights': insights.map((i) => i.toJson()).toList(),
        'blueprints': blueprints.map((b) => b.toJson()).toList(),
        'isOfflineFallback': isOfflineFallback,
        'version': version,
      };

  @override
  List<Object?> get props => [...super.props, kpis, recentActivity, blueprints];
}
