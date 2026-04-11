import '../../../../config/offline_fallback_state.dart';
import '../../../../src/factory_floor/ui_blueprint.dart';

class RegionalManagerOntarioDashboardViewModel implements OfflineFallbackState {
  @override
  final bool isOfflineFallback;
  final List<UIComponentBlueprint> blueprints;

  const RegionalManagerOntarioDashboardViewModel({
    this.isOfflineFallback = false,
    this.blueprints = const [],
  });

  factory RegionalManagerOntarioDashboardViewModel.assemble({required bool isOffline}) {
    return RegionalManagerOntarioDashboardViewModel(
      isOfflineFallback: isOffline,
      blueprints: [
        // Standard Zero-Code Orchestration Layout
        StatGridBlueprint(dataPayload: []), // Dynamic KPIs
        ActivityFeedBlueprint(dataPayload: []), // Live Stream
      ],
    );
  }
}
