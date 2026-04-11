import '../../../../config/offline_fallback_state.dart';
import '../../../../src/factory_floor/ui_blueprint.dart';

class RegionalManagerUsaDashboardViewModel implements OfflineFallbackState {
  @override
  final bool isOfflineFallback;
  final List<UIComponentBlueprint> blueprints;

  const RegionalManagerUsaDashboardViewModel({
    this.isOfflineFallback = false,
    this.blueprints = const [],
  });

  factory RegionalManagerUsaDashboardViewModel.assemble({required bool isOffline}) {
    return RegionalManagerUsaDashboardViewModel(
      isOfflineFallback: isOffline,
      blueprints: [
        // Standard Zero-Code Orchestration Layout
        StatGridBlueprint(dataPayload: []), // Dynamic KPIs
        ActivityFeedBlueprint(dataPayload: []), // Live Stream
      ],
    );
  }
}
