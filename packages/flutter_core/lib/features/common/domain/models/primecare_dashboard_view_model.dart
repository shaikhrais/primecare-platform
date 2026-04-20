// ignore_for_file: avoid_dynamic_calls, argument_type_not_assignable, inference_failure_on_instance_creation, strict_raw_type, inference_failure_on_function_invocation, undefined_identifier, inference_failure_on_collection_literal, undefined_named_parameter, return_of_invalid_type, prefer_single_quotes, invalid_assignment, non_type_as_type_argument
import '../../../../config/offline_fallback_state.dart';
import '../../../../src/factory_floor/ui_blueprint.dart';
import '../../../../src/models/dashboard_models.dart';

class PrimeCareDashboardViewModel implements OfflineFallbackState {
  @override
  final bool isOfflineFallback;
  final List<UniversalKpi> kpis;
  final List<dynamic> recentActivity;
  final List<UIComponentBlueprint> blueprints;

  final AIAnalyticsForecastingData? forecasting;

  const PrimeCareDashboardViewModel({
    this.isOfflineFallback = false,
    this.kpis = const [],
    this.recentActivity = const [],
    this.blueprints = const [],
    this.forecasting,
  });

  Map<String, dynamic> toJson() {
    return {
      'isOfflineFallback': isOfflineFallback,
      'kpis': kpis.map((k) => k.toJson()).toList(),
      'recentActivity': recentActivity,
      'blueprints': blueprints.map((b) => b.toJson()).toList(),
      'forecasting': forecasting?.toJson(),
    };
  }

  factory PrimeCareDashboardViewModel.fromJson(Map<String, dynamic> json) {
    return PrimeCareDashboardViewModel(
      isOfflineFallback: json['isOfflineFallback'] as bool? ?? false,
      kpis:
          (json['kpis'] as List<dynamic>?)
              ?.map((k) => UniversalKpi.fromJson(k as Map<String, dynamic>))
              .toList() ??
          const [],
      recentActivity: json['recentActivity'] as List<dynamic>? ?? const [],
      blueprints:
          (json['blueprints'] as List<dynamic>?)
              ?.map(
                (b) => UIComponentBlueprint.fromJson(b as Map<String, dynamic>),
              )
              .toList() ??
          const [],
      forecasting: json['forecasting'] != null
          ? AIAnalyticsForecastingData.fromJson(
              json['forecasting'] as Map<String, dynamic>,
            )
          : null,
    );
  }

  factory PrimeCareDashboardViewModel.fromDomain(
    Map<String, dynamic> data, {
    AIAnalyticsForecastingData? forecasting,
  }) {
    final kpis =
        (data['kpis'] as List<dynamic>?)
            ?.map((k) => UniversalKpi.fromJson(k as Map<String, dynamic>))
            .toList() ??
        [];

    final activity = data['recentActivity'] as List<dynamic>? ?? [];

    return PrimeCareDashboardViewModel(
      isOfflineFallback: false,
      kpis: kpis,
      recentActivity: activity,
      forecasting: forecasting,
      blueprints: _generateBlueprints(kpis, activity, forecasting: forecasting),
    );
  }

  factory PrimeCareDashboardViewModel.fromDashboardMetrics(
    DashboardMetrics metrics, {
    AIAnalyticsForecastingData? forecasting,
  }) {
    final mappedKpis =
        metrics.kpis.map((k) {
          return UniversalKpi(
            title: k.title,
            value: k.value,
            status: UniversalKpi.mapStatus(k.status),
            trend: double.tryParse(k.trend?.replaceAll('%', '') ?? '0') ?? 0.0,
          );
        }).toList();

    final activity = metrics.recentActivity.map((a) => a.toJson()).toList();

    return PrimeCareDashboardViewModel(
      isOfflineFallback: false,
      kpis: mappedKpis,
      recentActivity: activity,
      forecasting: forecasting,
      blueprints: _generateBlueprints(
        mappedKpis,
        activity,
        forecasting: forecasting,
      ),
    );
  }

  factory PrimeCareDashboardViewModel.assemble({required bool isOffline}) {
    return PrimeCareDashboardViewModel(
      isOfflineFallback: isOffline,
      blueprints: [
        const StatGridBlueprint(dataPayload: []),
        const ActivityFeedBlueprint(dataPayload: []),
      ],
    );
  }

  static List<UIComponentBlueprint> _generateBlueprints(
    List<UniversalKpi> kpis,
    List<dynamic> recentActivity, {
    AIAnalyticsForecastingData? forecasting,
  }) {
    return [
      StatGridBlueprint(dataPayload: kpis),
      if (forecasting != null) AIForecastingBlueprint(dataPayload: forecasting),
      if (recentActivity.isNotEmpty)
        ActivityFeedBlueprint(dataPayload: recentActivity),
    ];
  }
}
