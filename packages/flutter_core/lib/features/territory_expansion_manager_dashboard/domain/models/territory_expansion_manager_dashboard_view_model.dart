import '../../../../config/offline_fallback_state.dart';
import '../../../../src/factory_floor/ui_blueprint.dart';

class TerritoryExpansionManagerDashboardViewModel implements OfflineFallbackState {
  @override
  final bool isOfflineFallback;
  final List<UIComponentBlueprint> blueprints;

  const TerritoryExpansionManagerDashboardViewModel({
    this.isOfflineFallback = false,
    this.blueprints = const [],
  });

  factory TerritoryExpansionManagerDashboardViewModel.assemble({required bool isOffline}) {
    return TerritoryExpansionManagerDashboardViewModel(
      isOfflineFallback: isOffline,
      blueprints: [
        // Standard Zero-Code Orchestration Layout
        StatGridBlueprint(dataPayload: []), // Dynamic KPIs
        ActivityFeedBlueprint(dataPayload: []), // Live Stream
      ],
    );
  }
}
