import '../../../../config/offline_fallback_state.dart';
import '../../../../src/factory_floor/ui_blueprint.dart';

class TerritorySalesManagerDashboardViewModel implements OfflineFallbackState {
  @override
  final bool isOfflineFallback;
  final List<UIComponentBlueprint> blueprints;

  const TerritorySalesManagerDashboardViewModel({
    this.isOfflineFallback = false,
    this.blueprints = const [],
  });

  factory TerritorySalesManagerDashboardViewModel.assemble({required bool isOffline}) {
    return TerritorySalesManagerDashboardViewModel(
      isOfflineFallback: isOffline,
      blueprints: [
        // Standard Zero-Code Orchestration Layout
        StatGridBlueprint(dataPayload: []), // Dynamic KPIs
        ActivityFeedBlueprint(dataPayload: []), // Live Stream
      ],
    );
  }
}
