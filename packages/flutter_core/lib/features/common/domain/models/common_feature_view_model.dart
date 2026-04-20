// ignore_for_file: avoid_dynamic_calls, argument_type_not_assignable, inference_failure_on_instance_creation, strict_raw_type, inference_failure_on_function_invocation, undefined_identifier, inference_failure_on_collection_literal, undefined_named_parameter, return_of_invalid_type, prefer_single_quotes, invalid_assignment, non_type_as_type_argument
import '../../../../config/offline_fallback_state.dart';
import '../../../../src/factory_floor/ui_blueprint.dart';
import '../../../../src/models/dashboard_models.dart';

class CommonFeatureViewModel implements OfflineFallbackState {
  @override
  final bool isOfflineFallback;
  final List<UniversalKpi> kpis;
  final List<dynamic> recentActivity;
  final List<UIComponentBlueprint> blueprints;

  const CommonFeatureViewModel({
    this.isOfflineFallback = false,
    this.kpis = const [],
    this.recentActivity = const [],
    this.blueprints = const [],
  });

  factory CommonFeatureViewModel.fromDomain(Map<String, dynamic> data) {
    final kpis =
        (data['kpis'] as List<dynamic>?)
            ?.map((k) => UniversalKpi.fromJson(k as Map<String, dynamic>))
            .toList() ??
        [];

    return CommonFeatureViewModel(
      isOfflineFallback: false,
      kpis: kpis,
      recentActivity: data['recentActivity'] as List<dynamic>? ?? [],
      blueprints: [
        StatGridBlueprint(dataPayload: kpis),
        ActivityFeedBlueprint(
          dataPayload: data['recentActivity'] as List<dynamic>? ?? [],
        ),
      ],
    );
  }

  factory CommonFeatureViewModel.assemble({required bool isOffline}) {
    return CommonFeatureViewModel(
      isOfflineFallback: isOffline,
      blueprints: [
        const StatGridBlueprint(dataPayload: []),
        const ActivityFeedBlueprint(dataPayload: []),
      ],
    );
  }
}
